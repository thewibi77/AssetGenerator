extends Control

onready var ItemName = $ItemName
onready var Result = $Result

var generated_item: String

func _on_Generate_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if !is_Itemname_valid():
		willreturn = true
		Result.text = ""
	if willreturn: return
	Result.text = Generator.gen_item_model(ItemName.text)
	generated_item = ItemName.text
	


func _on_Copy_pressed():
	if Result.text == "":
		Global.handle_error("model empty")
		return
	OS.set_clipboard(Result.text)


func _on_SaveToFile_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if Result.text == "":
		Global.handle_error("model empty")
		willreturn = true
	if generated_item == "" || generated_item == null:
		Global.handle_error("no item model generated")
		willreturn = true
	if willreturn: return
	Global.save_json("src/main/resources/assets/"+Global.MOD_ID+"/models/item",generated_item,Result.text)


func _on_SaveTexture_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if !is_Itemname_valid(): willreturn = true
	if willreturn: return
	
	Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/item/"+ItemName.text)


func is_Itemname_valid() -> bool:
	if ItemName.text == "":
		Global.handle_error("item name not set")
		return false
	return true



func _on_EditButton_toggled(button_pressed):
	Result.readonly = !button_pressed
