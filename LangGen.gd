extends Control

onready var ItemBlockName = $ItemBlockName
onready var ItemBlockLocName = $ItemBlockLocName
onready var Result = $Result
onready var ItemCheck = $ItemCheck
onready var BlockCheck = $BlockCheck
onready var ResultLine = $ResultLine
onready var UndoButton = $Undo
onready var RedoButton = $Redo
var undo_text_array : Array = []
var redo_text_array : Array = []

enum MODE {BLOCK, ITEM}
var mode = MODE.ITEM



func _process(delta):
	RedoButton.disabled = redo_text_array.size()<=0
	UndoButton.disabled = undo_text_array.size()<=0

func _on_Generate_pressed():
	var willreturn = false
	var ModId = Global.ModId
	if !Global.is_MOD_ID_valid(): willreturn = true
	if ItemBlockName.text == "":
		Global.handle_error("object name not set")
		willreturn = true
	if ItemBlockLocName.text == "":
		Global.handle_error("object localised name not set")
		willreturn = true
	if willreturn: return
	
	if mode == MODE.ITEM:
		ResultLine.text = "\"item."+Global.MOD_ID+"."+ItemBlockName.text+"\": \""+ItemBlockLocName.text+"\""
	elif mode == MODE.BLOCK:
		ResultLine.text = "\"block."+Global.MOD_ID+"."+ItemBlockName.text+"\": \""+ItemBlockLocName.text+"\""
	


func _on_Copy_pressed():
	if Result.text == "":
		Global.handle_error("lang file is empty")
		return
	OS.set_clipboard(Result.text)


func _on_BlockCheck_toggled(button_pressed):
	ItemCheck.pressed = !button_pressed
	if button_pressed : 
		mode = MODE.BLOCK
	else :
		mode = MODE.ITEM


func _on_ItemCheck_toggled(button_pressed):
	BlockCheck.pressed = !button_pressed
	if button_pressed : 
		mode = MODE.ITEM
	else :
		mode = MODE.BLOCK


func _on_Save_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if Result.text == "": 
		Global.handle_error("lang file is empty")
		willreturn = true
	if willreturn : return
	
	Global.save_json("src/main/resources/assets/"+Global.MOD_ID+"/lang","en_us",Result.text)


func _on_LoadExist_pressed():
	push_undo()
	var file_text = Global.get_json_text("src/main/resources/assets/"+Global.MOD_ID+"/lang","en_us")
	if file_text == "":
		Global.handle_error("loaded file is either empty or non existent")
		return
	file_text = file_text.dedent()
	Result.text = file_text
	redo_text_array.clear()

func _on_ClearText_pressed():
	push_undo()
	Result.text = "{\n}"
	redo_text_array.clear()

func _on_AddLine_pressed():
	if ResultLine.text.length()<6:
		Global.handle_error("line invalid")
		return
	push_undo()
	var text_to_edit : String = Result.text
	text_to_edit = text_to_edit.dedent()
	text_to_edit.erase(text_to_edit.length()-2,2)
	if !text_to_edit.ends_with("{") && !text_to_edit.ends_with("/n"):
		text_to_edit = text_to_edit.insert(text_to_edit.length(),",")
	text_to_edit = text_to_edit.insert(text_to_edit.length(),"\n"+ResultLine.text+"\n}")
	Result.text = text_to_edit
	ResultLine.text = ""
	redo_text_array.clear()
	
	


func _on_Undo_pressed():
	redo_text_array.append(Result.text)
	Result.text = undo_text_array.pop_back()


func _on_Redo_pressed():
	undo_text_array.append(Result.text)
	Result.text = redo_text_array.pop_back()
	
func push_undo():
	undo_text_array.append(Result.text)
	if undo_text_array.size()> Global.max_undo:
		undo_text_array.pop_front()

func _on_EditButton_toggled(button_pressed):
	Result.readonly = !button_pressed
	ResultLine.editable = button_pressed
