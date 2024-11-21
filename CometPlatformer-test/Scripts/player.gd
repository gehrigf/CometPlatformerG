extends CharacterBody2D

const SPEED : float = 200.0
const JUMP_VELOCITY : float = -300.0
const MIN_GRAVITY_MULTIPLIER : float = 1.0
const JUMP_BUFFER : float = 0.2
const AIR_FAN_MULTIPLIER : float = 2.0

const UP : int = 0
const RIGHT : int = 1
const DOWN : int = 2
const LEFT : int = 3

var gravity : float = 300
var gravityMultiplier : float = 1.0
var jumpBufferCounter : float = 0.0
var canJump : bool = false

var posFanAcceleration : Vector2 = Vector2.ZERO
var negFanAcceleration : Vector2 = Vector2.ZERO

signal hitSpike

func _physics_process(delta):
	if is_on_floor():
		canJump = true
		jumpBufferCounter = 0.0
		
	if not is_on_floor():
		velocity.y += (gravity * gravityMultiplier) * delta
		gravityMultiplier += 2 * delta
		jumpBufferCounter += delta
		# allow jump for small frames after falling
		if(jumpBufferCounter >= JUMP_BUFFER):
			canJump = false
	else:
		gravityMultiplier = MIN_GRAVITY_MULTIPLIER

	if Input.is_action_just_pressed("jump") and canJump:
		velocity.y = JUMP_VELOCITY
		canJump = false

	# handle horizontal movement
	velocity.x = 0
	if negFanAcceleration.x == 0 and posFanAcceleration.x == 0:
		velocity.x = 0
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# handle fan forces
	velocity.x += posFanAcceleration.x * delta
	velocity.x += negFanAcceleration.x * delta
	velocity.y += posFanAcceleration.y * delta
	velocity.y += negFanAcceleration.y * delta
	
	# Debug Veloctity & Acceleration
	#print("Velocity: ", velocity)
	#print("Positive Fan: ", posFanAcceleration)
	#print("Negative Fan: ", negFanAcceleration)
	move_and_slide()

func apply_wind(direction, fan_force):
	if direction == UP:
		negFanAcceleration.y = -fan_force
		#print("UP!!!")
	elif direction == DOWN:
		posFanAcceleration.y = fan_force	
		#print("DOWN!!!")
	elif direction == RIGHT:
		if not is_on_floor():
			posFanAcceleration.x = fan_force * AIR_FAN_MULTIPLIER
		else:
			posFanAcceleration.x = fan_force
		#print("RIGHT!!!")
	elif direction == LEFT:
		if not is_on_floor():
			negFanAcceleration.x = -fan_force * AIR_FAN_MULTIPLIER
		else:
			negFanAcceleration.x = -fan_force
		#print("LEFT!!!")

func cancel_wind(direction):
	if direction == UP:
		negFanAcceleration.y = 0
	elif direction == DOWN:
		posFanAcceleration.y = 0	
	elif direction == RIGHT:
		posFanAcceleration.x = 0
	elif direction == LEFT:
		negFanAcceleration.x = 0


func _on_hitbox_body_entered(body):
	hitSpike.emit()

func _on_hitbox_area_entered(area):
	hitSpike.emit()
