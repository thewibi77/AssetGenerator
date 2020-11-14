extends Control

onready var CurrentDir = $CurrentDir
onready var CurrentJavaDir = $CurrentJavaDir

signal open_dir_button_pressed
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.CurrentDir = CurrentDir
	Global.CurrentJavaDir = CurrentJavaDir
	

func _on_SelectWorkingDir_pressed():
	Global.open_working_dir_dialog()


func _on_SelectJavaDir_pressed():
	Global.open_java_dir_dialog()
