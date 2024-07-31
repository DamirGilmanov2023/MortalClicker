extends Node

var Sonya_life:int=300
var Milina_life:int=500
var Jade_life:int=800
var Kitana_life:int=1000
var Sindel_life:int=1200
var Tanya_life:int=1500
var Frost_life:int=1800
var Cetrion_life:int=2000
var Skarlet_life:int=2200
var Ferra_life:int=2400

var Sonya_max_life:int=300
var Milina_max_life:int=500
var Jade_max_life:int=800
var Kitana_max_life:int=1000
var Sindel_max_life:int=1200
var Tanya_max_life:int=1500
var Frost_max_life:int=1800
var Cetrion_max_life:int=2000
var Skarlet_max_life:int=2200
var Ferra_max_life:int=2400

var Milina_disabled=true
var Jade_disabled=true
var Kitana_disabled=true
var Sindel_disabled=true
var Tanya_disabled=true
var Frost_disabled=true
var Cetrion_disabled=true
var Skarlet_disabled=true
var Ferra_disabled=true

var step:int=1

var score:int=0

var mass_add=[100,300,500,1000,2000,3000,5000]
#-------------------------------------------------------------------------------
func safe_data():
	var value:String
	value+=str(Sonya_life)+","+str(Milina_life)+","+str(Jade_life)+","+str(Kitana_life)+","
	value+=str(Sindel_life)+","+str(Tanya_life)+","+str(Frost_life)+","+str(Cetrion_life)+","
	value+=str(Skarlet_life)+","+str(Ferra_life)+";"
	
	value+=str(Sonya_max_life)+","+str(Milina_max_life)+","+str(Jade_max_life)+","+str(Kitana_max_life)+","
	value+=str(Sindel_max_life)+","+str(Tanya_max_life)+","+str(Frost_max_life)+","+str(Cetrion_max_life)+","
	value+=str(Skarlet_max_life)+","+str(Ferra_max_life)+";"
	
	value+="1," if Milina_disabled else "0,"
	value+="1," if Jade_disabled else "0,"
	value+="1," if Kitana_disabled else "0,"
	value+="1," if Sindel_disabled else "0,"
	value+="1," if Tanya_disabled else "0,"
	value+="1," if Frost_disabled else "0,"
	value+="1," if Cetrion_disabled else "0,"
	value+="1," if Skarlet_disabled else "0,"
	value+="1;" if Ferra_disabled else "0;"
	
	value+=str(step)+";"
	
	value+=str(score)+";"
	
	for x in mass_add:
		value+=str(x)+","
	value.substr(0,value.length()-1)
	
	js_set_data(value)
#-------------------------------------------------------------------------------
onready var win = JavaScript.get_interface("window")
#-------------------------------------------------------------------------------
signal ad(value)
var callback_ad = JavaScript.create_callback(self, '_ad')
func js_show_ad():
	win.ShowAd(callback_ad)

func _ad(args):
	emit_signal("ad",args[0])
#-------------------------------------------------------------------------------
signal foc_unfoc(value)
var callback_foc_unfoc=JavaScript.create_callback(self, '_foc_unfoc')

func js_foc_unfoc():
	win.foc_unfoc(callback_foc_unfoc)

func _foc_unfoc(args):
	emit_signal("foc_unfoc",args[0])
#-------------------------------------------------------------------------------
var callback_get_data=JavaScript.create_callback(self,'_get_data')

func js_get_data():
	win.get_data(callback_get_data)

func _get_data(args):
	var value=args[0]
	if value!="Null":
		var v=value.split(";")
		var life=v[0].split(",")
		var maxx=v[1].split(",")
		var disabled=v[2].split(",")
		var sstep=v[3]
		var sscore=v[4]
		var smass_add=v[5].split(",")
		Sonya_life=int(life[0])
		Milina_life=int(life[1])
		Jade_life=int(life[2])
		Kitana_life=int(life[3])
		Sindel_life=int(life[4])
		Tanya_life=int(life[5])
		Frost_life=int(life[6])
		Cetrion_life=int(life[7])
		Skarlet_life=int(life[8])
		Ferra_life=int(life[9])
		
		Sonya_max_life=int(maxx[0])
		Milina_max_life=int(maxx[1])
		Jade_max_life=int(maxx[2])
		Kitana_max_life=int(maxx[3])
		Sindel_max_life=int(maxx[4])
		Tanya_max_life=int(maxx[5])
		Frost_max_life=int(maxx[6])
		Cetrion_max_life=int(maxx[7])
		Skarlet_max_life=int(maxx[8])
		Ferra_max_life=int(maxx[9])
		
		step=int(sstep)
		
		score=int(sscore)
		
		mass_add.clear()
		for x in smass_add:
			mass_add.append(int(x))
#-------------------------------------------------------------------------------
func js_set_data(value):
	win.set_data(value)
#-------------------------------------------------------------------------------
func js_game_ready_api():
	win.GameReadyApi()
