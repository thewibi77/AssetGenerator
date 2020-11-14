extends Node

var MOD_ID : String = ""

var ModId : LineEdit
var Errors : TextEdit
var Main : Panel
var ClassTemplateMaker : Control

var CurrentDir : TextEdit
var CurrentJavaDir: TextEdit

var WorkingDirDialog : FileDialog
var JavaDirDialog : FileDialog
var SaveClassDialog : FileDialog

var save_path = "user://save/save"
var gen_path = "user://gen/"
var java_gen_path = "user://gen/src/main/java/net/yourname/yourmod/"
var max_undo: int = 50

enum TYPE {CLASS=0,LANG=1,BLOCK=2}

enum CLASSGENMODE {BLOCK=0}
enum LANGMODE {ITEM=0,BLOCK=1,ENTITY=2,ITEMGROUP=3}
enum BLOCKMODE {BLOCK=0,PILLAR=1,CROSS=2,ANVIL=3}

func _ready():
	StringHelper.path_to_package(java_gen_path)
	OS.min_window_size = Vector2(520, 500)
	OS.window_size = Vector2(1024, 600) 

func handle_error(errortext:String):
	print(errortext)
	Errors.text = Errors.text.insert(Errors.text.length(),errortext+"\n\n")
	Errors.scroll_vertical = 1000000
func clear_errors():
	Errors.text = ""




func save_modid():
	if MOD_ID != ModId.text:
		if ModId.text != "":
			MOD_ID = ModId.text
	var dir = Directory.new()
	if !dir.dir_exists(save_path.get_base_dir()):
		dir.make_dir_recursive(save_path.get_base_dir())
	var config = ConfigFile.new()
	config.load(save_path)
	config.set_value("mod", "MOD_ID", MOD_ID)
	config.save(save_path)

func save_gen_path():
	if gen_path == "":
		gen_path = "user://gen/"
	var dir = Directory.new()
	if !dir.dir_exists(save_path.get_base_dir()):
		dir.make_dir_recursive(save_path.get_base_dir())
	var config = ConfigFile.new()
	config.load(save_path)
	config.set_value("mod", "mod_dir", gen_path)
	config.save(save_path)
	CurrentDir.text = gen_path

func save_java_gen_path():
	if java_gen_path == "":
		java_gen_path = "user://gen/src/main/java/net/yourname/yourmod/"
	var dir = Directory.new()
	if !dir.dir_exists(save_path.get_base_dir()):
		dir.make_dir_recursive(save_path.get_base_dir())
	var config = ConfigFile.new()
	config.load(save_path)
	config.set_value("mod", "mod_java_dir", java_gen_path)
	config.save(save_path)
	CurrentJavaDir.text = java_gen_path




func load_modid():
	var config = ConfigFile.new()
	config.load(save_path)
	var modid = config.get_value("mod","MOD_ID")
	if modid != null && modid != "":
		MOD_ID = modid
		
func load_gen_path():
	var config = ConfigFile.new()
	config.load(save_path)
	var mod_dir = config.get_value("mod","mod_dir")
	if mod_dir != null && mod_dir != "":
		gen_path = mod_dir
	CurrentDir.text = gen_path

func load_java_gen_path():
	var config = ConfigFile.new()
	config.load(save_path)
	var mod_java_dir = config.get_value("mod","mod_java_dir")
	if mod_java_dir != null && mod_java_dir != "":
		java_gen_path = mod_java_dir
	CurrentJavaDir.text = java_gen_path









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





static func save_class(path:String,content:String):
	var dir = Directory.new()
	var file = File.new()
	
	if !dir.dir_exists(path.get_base_dir()):
		dir.make_dir_recursive(path.get_base_dir())
	file.open(path, File.WRITE)
	file.store_string(content)
	file.close()

static func get_class_text(path:String) -> String:
	var dir = Directory.new()
	var file = File.new()
	
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

func open_class_gen(objname:String,mode:int,submode:int):
	ClassTemplateMaker.open(objname,mode,submode)

func open_working_dir_dialog():
	WorkingDirDialog.popup()
	
func open_java_dir_dialog():
	JavaDirDialog.popup()
	
#func llload():
#	var file = File.new()
#	file.open("user://save_game.dat", File.READ)
#	var content = file.get_as_text()
#	file.close()
#	return content
