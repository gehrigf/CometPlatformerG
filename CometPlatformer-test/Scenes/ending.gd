extends Control

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		var nextLevel : Node = load("res://Scenes/Levels/level1.tscn").instantiate()
		get_tree().root.call_deferred("add_child", nextLevel)
		queue_free()
