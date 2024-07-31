extends Node2D

func _ready():
	$AnimationPlayer.play("icon")

func _on_AnimationPlayer_animation_finished(anim_name):
	Global.js_get_data()
	get_tree().change_scene_to_file("res://Scenes/Main/Main.tscn")
