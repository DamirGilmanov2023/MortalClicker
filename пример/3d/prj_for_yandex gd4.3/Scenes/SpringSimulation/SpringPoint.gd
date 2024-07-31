extends Node2D

#@export(NodePath) onready var base_position = get_node(base_position) as Sprite2D
@export var base_position: NodePath
@onready var base_sprite: Sprite2D = get_node(base_position) as Sprite2D
# Set by parent
var damping : float = 0.1
var speed : float = 1.0
var MAX_DISTANCE : float = 10.0

var global_time : float
var start_position : Vector2
var spring_offset := Vector2.ZERO

var start_flag=false
	

func _physics_process(delta : float):
	
	if Input.is_action_just_pressed("LMB"):
		var mouse_pos : Vector2 #(450,-55) #get_global_mouse_position()
		mouse_pos.x=450
		mouse_pos.y=-55
		global_position = mouse_pos
		start_position = mouse_pos
		global_time = 0.0
		
		var dist : float = global_position.distance_to(base_sprite.global_position)
		if dist > MAX_DISTANCE:
			global_position = base_sprite.global_position.direction_to(global_position) * MAX_DISTANCE + base_sprite.global_position
			start_position = global_position
		
		spring_offset = spring_offset.lerp(global_position - base_sprite.global_position, 0.4)
		start_flag=true
		return
	
	if start_flag:
		var t : float = global_time * speed
		var d := Vector2.ZERO
		var start_offset : Vector2 = start_position - base_sprite.global_position
		d = cos(t) * start_offset * exp(-damping * t)
		global_position = base_sprite.global_position + d
		global_time += delta
		
		spring_offset = global_position - base_sprite.global_position
