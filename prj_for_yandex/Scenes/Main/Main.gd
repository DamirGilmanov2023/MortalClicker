extends Control

func _ready():
	$d2.disabled=Global.Milina_disabled
	$d3.disabled=Global.Jade_disabled
	$d4.disabled=Global.Kitana_disabled
	$d5.disabled=Global.Sindel_disabled
	$d6.disabled=Global.Tanya_disabled
	$d7.disabled=Global.Frost_disabled
	$d8.disabled=Global.Cetrion_disabled
	$d9.disabled=Global.Skarlet_disabled
	$d10.disabled=Global.Ferra_disabled
	
	Global.connect('foc_unfoc',self,'_foc_unfoc')
	Global.js_foc_unfoc()
	$Back.play()
	if Global.game_start:
		Global.game_start=false
		Global.js_game_ready_api()
		Global.js_show_ad()
		$Back.stop()
		get_tree().paused=true
	Global.connect("ad",self,'_ad')

func _foc_unfoc(value):
	if value=="foc":
		get_tree().paused=false
	elif value=="unfoc":
		get_tree().paused=true

func _ad(value):
	print(value)
	print(typeof(value))
	if value==true or value==false:
		get_tree().paused=false
		$Back.play()

func _on_d1_pressed():
	$Select.play()
	$AnimationPlayer.play("Sonya")
	$Back.stop()

func _on_d2_pressed():
	$Select.play()
	$AnimationPlayer.play("Milina")
	$Back.stop()

func _on_d3_pressed():
	$Select.play()
	$AnimationPlayer.play("Jade")
	$Back.stop()

func _on_d4_pressed():
	$Select.play()
	$AnimationPlayer.play("Kitana")
	$Back.stop()

func _on_d5_pressed():
	$Select.play()
	$AnimationPlayer.play("Sindel")
	$Back.stop()

func _on_d6_pressed():
	$Select.play()
	$AnimationPlayer.play("Tanya")
	$Back.stop()

func _on_d7_pressed():
	$Select.play()
	$AnimationPlayer.play("Frost")
	$Back.stop()

func _on_d8_pressed():
	$Select.play()
	$AnimationPlayer.play("Cetrion")
	$Back.stop()

func _on_d9_pressed():
	$Select.play()
	$AnimationPlayer.play("Skarlet")
	$Back.stop()

func _on_d10_pressed():
	$Select.play()
	$AnimationPlayer.play("Ferra")
	$Back.stop()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="Sonya":
		get_tree().change_scene("res://Scenes/Sonya/Sonya.tscn")
	elif anim_name=="Milina":
		get_tree().change_scene("res://Scenes/Milina/Milina.tscn")
	elif anim_name=="Jade":
		get_tree().change_scene("res://Scenes/Jade/Jade.tscn")
	elif anim_name=="Kitana":
		get_tree().change_scene("res://Scenes/Kitana/Kitana.tscn")
	elif anim_name=="Sindel":
		get_tree().change_scene("res://Scenes/Sindel/Sindel.tscn")
	elif anim_name=="Tanya":
		get_tree().change_scene("res://Scenes/Tanya/Tanya.tscn")
	elif anim_name=="Frost":
		get_tree().change_scene("res://Scenes/Frost/Frost.tscn")
	elif anim_name=="Cetrion":
		get_tree().change_scene("res://Scenes/Cetrion/Cetrion.tscn")
	elif anim_name=="Skarlet":
		get_tree().change_scene("res://Scenes/Skarlet/Skarlet.tscn")
	elif anim_name=="Ferra":
		get_tree().change_scene("res://Scenes/Ferra/Ferra.tscn")
