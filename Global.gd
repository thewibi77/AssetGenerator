extends Node

var MOD_ID : String = ""

var ModId : LineEdit
var Errors : TextEdit

var save_path = "user://save/save"
var gen_path = "user://gen/"
var max_undo: int = 50

enum BLOCKMODE {BLOCK,PILLAR,CROSS,ANVIL}

func _ready():
	OS.min_window_size = Vector2(520, 500)

func handle_error(errortext:String):
	Errors.text = Errors.text.insert(Errors.text.length(),errortext+"\n\n")
	Errors.scroll_vertical = 100000
func clear_errors():
	Errors.text = ""

static func save_json(subfolder:String,filename:String,content:String):
	var dir = Directory.new()
	var file = File.new()
	var path = String(Global.gen_path+subfolder+"/"+filename+".json")
	
	if !dir.dir_exists(path.get_base_dir()):
		dir.make_dir_recursive(path.get_base_dir())
	file.open(path, File.WRITE)
	file.store_string(content)
	file.close()

static func get_json_text(subfolder:String,filename:String) -> String:
	var dir = Directory.new()
	var file = File.new()
	var path = String(Global.gen_path+subfolder+"/"+filename+".json")
	
	if !dir.dir_exists(path.get_base_dir()):
		dir.make_dir_recursive(path.get_base_dir())
	
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content


func is_MOD_ID_valid() -> bool:
	if MOD_ID == "":
		if ModId.text == "":
			handle_error("MOD_ID not set")
			return false
		else:
			MOD_ID = ModId.text
		return true
	if MOD_ID != ModId.text:
		MOD_ID = ModId.text
	return true

#func llload():
#	var file = File.new()
#	file.open("user://save_game.dat", File.READ)
#	var content = file.get_as_text()
#	file.close()
#	return content
