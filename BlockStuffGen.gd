extends Control

onready var BlockName = $BlockName
onready var ResultBlockModel = $ResultBlockModel
onready var ResultItemModel = $ResultItemModel
onready var ResultBlockState = $ResultBlockState
onready var ModeChooser = $ModeChooser

var generated_block_for_block: String
var generated_block_for_item: String
var generated_block_for_state: String



func _on_GenerateBlockModel_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if !is_Blockname_valid() :
		ResultBlockModel.text = ""
		willreturn = true
	if willreturn : return
	
	ResultBlockModel.text = Generator.gen_block_model(BlockName.text,ModeChooser.selected)
	generated_block_for_block = BlockName.text


func _on_GenerateItemModel_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if !is_Blockname_valid() :
		ResultItemModel.text = ""
		willreturn = true
	if willreturn : return
	
	ResultItemModel.text = Generator.gen_itemblock_model(BlockName.text,ModeChooser.selected)
	generated_block_for_item = BlockName.text


func _on_GenerateBlockState_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if !is_Blockname_valid() :
		ResultBlockState.text = ""
		willreturn = true
	if willreturn : return
	
	ResultBlockState.text = Generator.gen_blockstate(BlockName.text,ModeChooser.selected)
	generated_block_for_state = BlockName.text



func _on_CopyBlockModel_pressed():
	if ResultBlockModel.text == "":
		Global.handle_error("block model empty")
		return
	
	OS.set_clipboard(ResultBlockModel.text)


func _on_CopyItemModel_pressed():
	if ResultItemModel.text == "":
		Global.handle_error("item model empty")
		return
	
	OS.set_clipboard(ResultItemModel.text)


func _on_CopyBlockState_pressed():
	if ResultBlockState.text == "":
		Global.handle_error("blockstate empty")
		return
	
	OS.set_clipboard(ResultBlockState.text)


func _on_SaveBlockModel_pressed():
	var willreturn = false
	var ModId = Global.ModId
	if !Global.is_MOD_ID_valid(): willreturn = true
	if ResultBlockModel.text == "":
		Global.handle_error("block model empty")
		willreturn = true
	if generated_block_for_block == "" || generated_block_for_block == null:
		Global.handle_error("no block model generated")
		willreturn = true
	if willreturn : return
	
	Global.save_json("src/main/resources/assets/"+Global.MOD_ID+"/models/block",generated_block_for_block,ResultBlockModel.text)


func _on_SaveItemModel_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if ResultItemModel.text == "":
		Global.handle_error("blockitem model empty")
		willreturn = true
	if generated_block_for_item == "" || generated_block_for_item == null:
		Global.handle_error("no blockitem model generated")
		willreturn = true
	if willreturn : return
	
	Global.save_json("src/main/resources/assets/"+Global.MOD_ID+"/models/item",generated_block_for_item,ResultItemModel.text)


func _on_SaveBlockState_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if ResultBlockState.text == "":
		Global.handle_error("blockstate empty")
		willreturn = true
	if generated_block_for_state == "" || generated_block_for_state == null:
		Global.handle_error("no blockstate generated")
		willreturn = true
	if willreturn : return
	
	Global.save_json("src/main/resources/assets/"+Global.MOD_ID+"/blockstates",generated_block_for_state,ResultBlockState.text)


func _on_GenerateAll_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if !is_Blockname_valid() : willreturn = true
	if willreturn : return
	
	_on_GenerateBlockModel_pressed()
	_on_GenerateItemModel_pressed()
	_on_GenerateBlockState_pressed()


func _on_SaveAll_pressed():
	_on_SaveBlockModel_pressed()
	_on_SaveItemModel_pressed()
	_on_SaveBlockState_pressed()


func _on_SaveTexture_pressed():
	var willreturn = false
	if !Global.is_MOD_ID_valid(): willreturn = true
	if !is_Blockname_valid() : willreturn = true
	if willreturn : return
	
	Generator.gen_block_texture(BlockName.text,ModeChooser.selected)



func is_Blockname_valid() -> bool:
	if BlockName.text == "":
		Global.handle_error("block name not set")
		return false
	return true


func _on_EditButton_toggled(button_pressed):
	ResultBlockModel.readonly = !button_pressed
	ResultItemModel.readonly = !button_pressed
	ResultBlockState.readonly = !button_pressed
