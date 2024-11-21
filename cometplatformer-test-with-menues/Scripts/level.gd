extends Node2D

@export var nextLevelNum : int = 2
@onready var player : CharacterBody2D
@onready var killZone : Node2D = get_node("Kill Zone")
@onready var spawnPoint : Node2D = get_node("Respawn")
@onready var respawnLocation : Vector2

const LAST_LEVEL : int = 7

func _ready():
	player = get_node("Player")
	respawnLocation = player.global_position
	# print(player.global_position)
	# print(respawnLocation)

func _process(delta):
	if player.global_position.y > killZone.global_position.y:
		# print("dead")
		reset_player()
		
func reset_player():
	player.global_position = respawnLocation
	player.velocity = Vector2.ZERO

func _on_player_hit_spike():
	reset_player()
	
func _on_warp_zone_body_entered(body):
	if nextLevelNum >= LAST_LEVEL:
		var nextLevel : Node = load("res://Scenes/ending.tscn").instantiate()
		get_tree().root.call_deferred("add_child", nextLevel)
		queue_free()
		pass
	else:
		var nextLevel : Node = load("res://Scenes/Levels/level" + str(nextLevelNum) + ".tscn").instantiate()
		get_tree().root.call_deferred("add_child", nextLevel)
		queue_free()
