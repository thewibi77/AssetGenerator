extends Node


var lang_mode_string_array : PoolStringArray = ["Item","Block","Entity","Item Group/Creative Tab"]
var block_mode_string_array : PoolStringArray = ["Block","Pillar/Log","Cross/Plant","Anvil"]
var class_gen_mode_string_array : PoolStringArray = ["Block Class"]


enum CLASSGENMODE {BLOCK=0}

enum LANGMODE {ITEM=0,BLOCK=1,ENTITY=2,ITEMGROUP=3}
enum BLOCKMODE {BLOCK=0,PILLAR=1,CROSS=2,ANVIL=3}


func blockmode_to_string(mode:int) -> String:
	if mode >= block_mode_string_array.size():
		Global.handle_error("Can't find display string for Block Mode: "+String(mode))
		return "Block_Mode_"+String(mode)
	return block_mode_string_array[mode]
	
func langmode_to_string(mode:int) -> String:
	if mode >= lang_mode_string_array.size():
		Global.handle_error("Can't find display string for Lang Mode: "+String(mode))
		return "Lang_Mode_"+String(mode)
	return lang_mode_string_array[mode]

func classmode_to_string(mode:int) -> String:
	if mode >= class_gen_mode_string_array.size():
		Global.handle_error("Can't find display string for Class Mode: "+String(mode))
		return "Class_Mode_"+String(mode)
	return lang_mode_string_array[mode]

func mode_to_string(type:int,mode:int) -> String:
	match type:
		Global.TYPE.BLOCK:
			if mode >= block_mode_string_array.size():
				Global.handle_error("Can't find display string for Block Mode: "+String(mode))
				return "Block_Mode_"+String(mode)
			return block_mode_string_array[mode]
		Global.TYPE.LANG:
			if mode >= lang_mode_string_array.size():
				Global.handle_error("Can't find display string for Lang Mode: "+String(mode))
				return "Lang_Mode_"+String(mode)
			return lang_mode_string_array[mode]
		Global.TYPE.CLASS:
			print("PRDRTTTTT")
			if mode >= class_gen_mode_string_array.size():
				Global.handle_error("Can't find display string for Class Mode: "+String(mode))
				return "Class_Mode_"+String(mode)
			return class_gen_mode_string_array[mode]
	Global.handle_error("INVALID TYPE : "+ String(mode) +" ! TEXT CAN'T SHOW !!\nTHIS MEANS THAT THERE IS AN ISSUE IN THIS VERSION, THAT IS MY FAULT SORRY :(")
	return "ERROR"

func class_mode_to_subfolder(mode:int) -> String:
	match mode:
		Global.CLASSGENMODE.BLOCK:
			return "/blocks"
	Global.handle_error("INVALID CLASS TYPE : "+ String(mode) +" ! CAN'T GET SUBFOLDER !!\nTHIS MEANS THAT THERE IS AN ISSUE IN THIS VERSION, THAT IS MY FAULT SORRY :(")
	return ""
