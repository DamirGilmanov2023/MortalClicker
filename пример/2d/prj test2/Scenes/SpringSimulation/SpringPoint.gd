extends Node2D

export(NodePath) onready var base_position = get_node(base_position) as Sprite
# Set by parent
var damping : float = 0.2
var speed : float = 1.0
var MAX_DISTANCE : float = 100.0

var global_time : float
var start_position : Vector2
var spring_offset := Vector2.ZERO

var start_flag=false

var drag:bool=false
var mouse_pos:Vector2
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			drag=true
		else:
			drag=false

func _physics_process(delta : float):
	if drag:
		drag=false
		mouse_pos.x=450
		mouse_pos.y=-200
		global_position = mouse_pos
		start_position = mouse_pos
		global_time = 0.0
		
		var dist : float = global_position.distance_to(base_position.global_position)
		if dist > MAX_DISTANCE:
			global_position = base_position.global_position.direction_to(global_position) * MAX_DISTANCE + base_position.global_position
			start_position = global_position
		
		spring_offset = spring_offset.linear_interpolate(global_position - base_position.global_position, 0.4)
		start_flag=true
		return
	
	if start_flag:
		var t : float = global_time * speed
		var d := Vector2.ZERO
		var start_offset : Vector2 = start_position - base_position.global_position
		d = cos(t) * start_offset * exp(-damping * t)
		global_position = base_position.global_position + d
		global_time += delta
		
		spring_offset = global_position - base_position.global_position
