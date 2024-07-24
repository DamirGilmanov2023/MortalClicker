extends Node2D

export(float) var damping : float = 0.2
export(float) var speed : float = 8.0
export(float) var MAX_DISTANCE : float = 100.0

onready var spring_point = $SpringPoint

func _process(_delta):
	spring_point.damping = damping
	spring_point.speed = speed
	spring_point.MAX_DISTANCE = MAX_DISTANCE
