extends CharacterBody2D

const INITIAL_SPEED : int = 10
const INITIAL_GRAVITY : float = 300
const ACCELERATION : float = 300

@onready var recTimer : Timer = get_node("Recovery Timer")
@onready var ascTimer : Timer = get_node("Ascend Timer")
@onready var peakTimer : Timer = get_node("Peak Timer")
@onready var detectionArea : Area2D = get_node("Detection Area")
@onready var hurtBox : Area2D = get_node("Hurtbox")
@onready var initialPosition : Vector2 = global_position
var gravity : float = INITIAL_GRAVITY

var isFalling : bool = false
var inRecovery : bool = false
var atPeak : bool = false

func _ready():
	pass
	
func _process(delta):
	if isFalling:
		gravity += ACCELERATION * delta
		velocity.y += gravity * delta
	elif not detectionArea.get_overlapping_bodies().is_empty() and not inRecovery:
		isFalling = true
		hurtBox.monitorable = true
		gravity = INITIAL_GRAVITY
		velocity.y = INITIAL_SPEED
	# prepare to come back up after rising
	if is_on_floor() and not inRecovery:
		isFalling = false
		inRecovery = true
		hurtBox.monitorable = false
		gravity = 0
		recTimer.start()
	move_and_slide()

func _on_recovery_timer_timeout():
	velocity.y = -(global_position.y - initialPosition.y) / ascTimer.wait_time
	ascTimer.start()

func _on_ascend_timer_timeout():
	velocity.y = 0
	global_position = initialPosition
	peakTimer.start()

func _on_peak_timer_timeout():
	inRecovery = false
