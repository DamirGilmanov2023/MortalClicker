extends Spatial

onready var spring_point = $SpringSim/SpringPoint
onready var breasts = $Body/Breasts

func _ready():
	$ui/progress.max_value=Global.Jade_max_life
	$ui/progress.value=Global.Jade_life
	$ui/life.text=str(Global.Jade_life)
	$ui/score.text=str(Global.score)
	$ui/label_add.text=str(Global.mass_add[0])+"\n"+"клик +1"
	if Global.score>Global.mass_add[0]:
		$ui/button_add.disabled=false
	$rekl/T.start()
	
	Global.connect('foc_unfoc',self,'_foc_unfoc')
	Global.js_foc_unfoc()
	
	Global.connect("ad",self,'_ad')
	
	$Audio/Play3.play()
	
	Global.click=true
	
func _foc_unfoc(value):
	if value=="foc":
		get_tree().paused=false
	elif value=="unfoc":
		get_tree().paused=true

func _ad(value):
	if value==true or value==false:
		get_tree().paused=false
		$Audio/Play3.play()
		Global.click=true

var flag_safe:bool=true

var drag:bool=false
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			drag=true
		else:
			drag=false

func _physics_process(_delta):
	var o : Vector2 = spring_point.spring_offset
	var mat : ShaderMaterial = breasts.material_override
	mat.set_shader_param("spring_offset", o)
	
	if drag and Global.click:
		drag=false
		if flag_safe:
			flag_safe=false
			$TimerSafe.start()
		Global.Jade_life-=Global.step
		if Global.Jade_life>0:
			$ui/progress.value=Global.Jade_life
			$ui/life.text=str(Global.Jade_life)
		else:
			$ui/progress.value=0
			$ui/life.text=str(0)
		Global.score+=Global.step
		$ui/score.text=str(Global.score)
		if Global.score>Global.mass_add[0]:
			$ui/button_add.disabled=false
		if Global.Jade_life<=0:
			Global.Jade_max_life=5000
			Global.Jade_life=5000
			Global.Kitana_disabled=false
			Global.safe_data()
			$Audio/Play3.stop()
			yield(get_tree().create_timer(0.3),"timeout")
			get_tree().change_scene("res://Scenes/Kitana/Kitana.tscn")

func _on_button_back_pressed():
	if Global.click:
		Global.safe_data()
		$Audio/Play3.stop()
		yield(get_tree().create_timer(0.3),"timeout")
		get_tree().change_scene("res://Scenes/Main/Main.tscn")

func _on_button_add_pressed():
	if Global.click:
		$ui/button_add.disabled=true
		Global.score-=Global.mass_add[0]
		$ui/score.text=str(Global.score)
		if(len(Global.mass_add)>1):
			Global.mass_add.pop_front()
		$ui/label_add.text=str(Global.mass_add[0])+"\n"+"клик +1"
		Global.step+=1

var time=2
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
	Global.click=false
	$Audio/Play3.stop()
	$rekl.visible=true
	time=2
	$rekl/Label.text="Реклама через "+str(time)
	$rekl/Timer.start()

func _on_TimerSafe_timeout():
	Global.safe_data()
	flag_safe=true
