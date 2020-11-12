extends Control

onready var ModId = $ModId
onready var ChooseDir = $ChooseDir
onready var CurrentDir = $TabContainer/Directory/CurrentDir

func _ready():
	load_modid()
	Global.ModId = ModId
	ModId.text = Global.MOD_ID
	load_gen_path()
	ChooseDir.current_path = Global.gen_path
	ChooseDir.current_dir = Global.gen_path
	CurrentDir.text = Global.gen_path

func _on_SaveModId_pressed():
	Global.MOD_ID = ModId.text
	save_modid()




func save_modid():
	if Global.MOD_ID != ModId.text:
		if ModId.text != "":
			Global.MOD_ID = ModId.text
	var save_path = Global.save_path
	var dir = Directory.new()
	if !dir.dir_exists(save_path.get_base_dir()):
		dir.make_dir_recursive(save_path.get_base_dir())
	var config = ConfigFile.new()
	config.load(save_path)
	config.set_value("mod", "MOD_ID", Global.MOD_ID)
	config.save(save_path)

func save_gen_path():
	if Global.gen_path == "":
		Global.gen_path = "user://gen/"
	var save_path = Global.save_path
	var dir = Directory.new()
	if !dir.dir_exists(save_path.get_base_dir()):
		dir.make_dir_recursive(save_path.get_base_dir())
	var config = ConfigFile.new()
	config.load(save_path)
	config.set_value("mod", "mod_dir", Global.gen_path)
	config.save(save_path)
	CurrentDir.text = Global.gen_path

func load_modid():
	var config = ConfigFile.new()
	var save_path = Global.save_path
	config.load(save_path)
	var modid = config.get_value("mod","MOD_ID")
	if modid != null && modid != "":
		Global.MOD_ID = modid
		
func load_gen_path():
	var config = ConfigFile.new()
	var save_path = Global.save_path
	config.load(save_path)
	var mod_dir = config.get_value("mod","mod_dir")
	if mod_dir != null && mod_dir != "":
		Global.gen_path = mod_dir


func _on_ChooseDir_dir_selected(dir):
	Global.gen_path = String(dir+"/")
	save_gen_path()


func _on_SelectWorkingDir_pressed():
	ChooseDir.popup()


func _on_ClearErrors_pressed():
	Global.clear_errors()
