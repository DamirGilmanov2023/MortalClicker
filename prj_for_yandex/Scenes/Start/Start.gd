extends Node2D

func _ready():
	$AnimationPlayer.play("icon")
	yield(get_tree().create_timer(3),"timeout")
	Global.js_get_data()

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Main/Main.tscn")
