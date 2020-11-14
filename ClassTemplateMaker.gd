extends Control

onready var SaveClassDialog = $SaveClassDialog
onready var ClassResult = $ClassResult
onready var ClassMode = $ClassMode
onready var Template = $Template
onready var ClassName = $ClassName

var class_gen_mode = 0
var template_gen_mode = 0

func _ready():
	hide()
	SaveClassDialog.current_dir = Global.java_gen_path
	SaveClassDialog.current_path = Global.java_gen_path
	Global.ClassTemplateMaker = self
	Global.SaveClassDialog = SaveClassDialog
	
	ClassMode.selected = class_gen_mode
	Template.selected = template_gen_mode

func open(objname:String,type:int,mode:int):
	ClassName.text = StringHelper.name_to_class(objname)
	
	ClassMode.selected = type
	class_gen_mode = type
	Template.selected = mode
	template_gen_mode = type
	ClassResult.text =""
	show()


func close():
	ClassName.text =""
	ClassResult.text =""
	hide()

func _on_EditButton_toggled(button_pressed):
	ClassResult.readonly = !button_pressed


func _on_GenerateClass_pressed():
	ClassResult.text = Generator.gen_class(ClassMode.selected,Template.selected,ClassName.text)


func _on_ClassMode_item_selected(index):
	print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
	class_gen_mode = index


func _on_Template_item_selected(index):
	template_gen_mode = index


func _on_SaveClassAs_pressed():
	var willreturn = false
	if ClassName.text == "":
		Global.handle_error("Class Name is empty")
		willreturn = true
	if ClassResult.text == "":
		Global.handle_error("Class is empty")
		willreturn = true
	if willreturn: return
		
	SaveClassDialog.current_file = ClassName.text
	SaveClassDialog.popup()


func _on_SaveClass_pressed():
	var willreturn = false
	if ClassName.text == "":
		Global.handle_error("Class Name is empty")
		willreturn = true
	if ClassResult.text == "":
		Global.handle_error("Class is empty")
		willreturn = true
	if willreturn: return
	var path = StringHelper.standardize_folder_path(Global.java_gen_path)
	path = StringHelper.standardize_folder_path(path + ToStringHelp.class_mode_to_subfolder(ClassMode.selected))
	path = path + ClassName.text+".java"
	Global.save_class(path,ClassResult.text)


func _on_SaveClassDialog_dir_selected(dir:String):
	var content = ClassResult.text
	var package = dir
	package = StringHelper.path_to_package(package)
	content.erase(0,content.find(";"))
	content = content.insert(0,"package "+package+";")
	
	dir = StringHelper.standardize_folder_path(dir)
	
	dir = dir.insert(dir.length(),ClassName.text+".java")
	
	Global.save_class(dir,content)
	print(dir)


func _on_CloseButton_pressed():
	close()
