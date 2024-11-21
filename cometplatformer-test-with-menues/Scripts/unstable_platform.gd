extends StaticBody2D

@onready var breakTimer : Timer = get_node("Break Timer")
@onready var repairTimer : Timer = get_node("Repair Timer")
@onready var collider : CollisionShape2D = get_node("CollisionShape2D")
@onready var sprite : Sprite2D = get_node("Sprite2D")

var isBroken : bool = false

func initiate_break():
	breakTimer.start()
	sprite.modulate = Color.FIREBRICK
	
func initiate_repiar():
	repairTimer.start()

func _on_break_timer_timeout():
	isBroken = true
	collider.disabled = true
	sprite.visible = false
	sprite.modulate = Color.WHITE
	initiate_repiar()

func _on_repair_timer_timeout():
	isBroken = false
	collider.disabled = false
	sprite.visible = true

func _on_break_region_body_entered(body):
	if not isBroken:
		# print("Initate Break!")
		initiate_break()
