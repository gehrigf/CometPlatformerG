extends Node2D

const UP : int = 0
const RIGHT : int = 1
const DOWN : int = 2
const LEFT : int = 3

@export var fan_force : float = 5000
@export var fan_time : float = 3.5
@export var particle : int = 50
@export var particleSpeed : int = 1
@export var isPermanent : bool = false

@onready var particles : GPUParticles2D = get_node("Particles")
@onready var timer : Timer = get_node("Timer")

var zone : Area2D
var direction : int = 0
var isActive : bool = true
# 0 -> UP, 1 -> RIGHT, 2 -> DOWN, 3 -> LEFT

func _ready():
	zone = %"Air Zone"
	direction = ceili((rotation_degrees - 5) / 90)
	var scaleValue = transform.get_scale().x
	particles.amount = particle
	particles.speed_scale = particleSpeed
	particles.process_material.scale_min = scaleValue
	particles.process_material.scale_max = scaleValue + 1
	timer.wait_time = fan_time

func _process(delta):
	if isActive:
		for body in zone.get_overlapping_bodies():
			if body.has_method("apply_wind"):
				body.apply_wind(direction, fan_force)

func toggle():
	if not isPermanent:
		isActive = not isActive
		particles.emitting = not particles.emitting

func _on_air_zone_body_exited(body):
	if body.has_method("cancel_wind"):
		body.cancel_wind(direction)

func _on_timer_timeout():
	for body in zone.get_overlapping_bodies():
			if body.has_method("apply_wind"):
				body.cancel_wind(direction)
	toggle()
