extends Panel

onready var ModId = $ModId
onready var ChooseDir = $ChooseDir
onready var ChooseJavaDir = $ChooseJavaDir
onready var CurrentDir = $TabContainer/Directory/CurrentDir

func _ready():
	print("AMREADY")
	Global.Main = self
	Global.WorkingDirDialog = ChooseDir
	Global.JavaDirDialog = ChooseJavaDir
	Global.load_modid()
	Global.ModId = ModId
	ModId.text = Global.MOD_ID
	Global.load_gen_path()
	Global.load_java_gen_path()
	ChooseDir.current_path = Global.gen_path
	ChooseDir.current_dir = Global.gen_path
	
	ChooseJavaDir.current_path = Global.java_gen_path
	ChooseJavaDir.current_dir = Global.java_gen_path
	
	Global.SaveClassDialog.current_dir = Global.java_gen_path
	Global.SaveClassDialog.current_path = Global.java_gen_path
	
	Global.CurrentDir.text = Global.gen_path
	Global.CurrentJavaDir.text = Global.java_gen_path

func _on_SaveModId_pressed():
	Global.MOD_ID = ModId.text
	Global.save_modid()











func _on_ChooseDir_dir_selected(dir):
	Global.gen_path = String(dir+"/")
	Global.save_gen_path()


func _on_ClearErrors_pressed():
	Global.clear_errors()


func _on_Directory_open_dir_button_pressed():
	ChooseDir.popup()


func _on_ChooseJavaDir_dir_selected(dir):
	Global.java_gen_path = String(dir+"/")
	Global.save_java_gen_path()

