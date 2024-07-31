extends Node3D

@onready var spring_point = $SpringSim/SpringPoint
@onready var breasts = $Body/Breasts

func _ready():
	$ui/progress.max_value=Global.Ferra_max_life
	$ui/progress.value=Global.Ferra_life
	$ui/life.text=str(Global.Ferra_life)
	$ui/score.text=str(Global.score)
	$ui/label_add.text=str(Global.mass_add[0])+"\n"+"клик +1"
	if Global.score>Global.mass_add[0]:
		$ui/button_add.disabled=false
	$rekl/T.start()
	
	Global.connect('foc_unfoc',Callable(self,'_foc_unfoc'))
	Global.js_foc_unfoc()
	
	Global.connect("ad",Callable(self,'_ad'))
	
func _foc_unfoc(value):
	if value=="foc":
		get_tree().paused=false
	elif value=="unfoc":
		get_tree().paused=true

func _ad(value):
	get_tree().paused=false
	$Audio/Play5.stream_paused=false

var flag_safe:bool=true

func _physics_process(_delta):
	var o : Vector2 = spring_point.spring_offset
	var mat : ShaderMaterial = breasts.material_override
	mat.set_shader_parameter("spring_offset", o)
	
	if Input.is_action_just_pressed("LMB"):
		if flag_safe:
			flag_safe=false
			$TimerSafe.start()
		Global.Ferra_life-=Global.step
		$ui/progress.value=Global.Ferra_life
		$ui/life.text=str(Global.Ferra_life)
		Global.score+=Global.step
		$ui/score.text=str(Global.score)
		if Global.score>Global.mass_add[0]:
			$ui/button_add.disabled=false
		if Global.Ferra_life<=0:
			Global.Ferra_life=2400
			Global.Ferra_max_life=2400
			get_tree().change_scene_to_file("res://Scenes/Sonya/Sonya.tscn")

func _on_button_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main/Main.tscn")

func _on_button_add_pressed():
	$ui/button_add.disabled=true
	Global.score-=Global.mass_add[0]
	$ui/score.text=str(Global.score)
	if(len(Global.mass_add)>1):
		Global.mass_add.pop_front()
	$ui/label_add.text=str(Global.mass_add[0])+"\n"+"клик +1"
	Global.step+=1

var time=3
func _on_Timer_timeout():
	time-=1
	if time>0:
		$rekl/Label.text="Реклама через "+str(time)
		$rekl/Timer.start()
	else:
		Global.js_show_ad()
		get_tree().paused=true
		$rekl.visible=false
		$rekl/T.start()
	
func _on_T_timeout():
	$Audio/Play5.stream_paused=true
	$rekl.visible=true
	time=3
	$rekl/Label.text="Реклама через "+str(time)
	$rekl/Timer.start()

func _on_TimerSafe_timeout():
	Global.safe_data()
	flag_safe=true
