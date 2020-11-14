extends OptionButton

#export var ChoiceArray : PoolStringArray = []

export(Global.TYPE) var type = Global.TYPE.LANG



func _ready():
	var i = 0
#	for key in ChoiceArray:
#		add_item (key, i)
#		i+=1
	match type:
		Global.TYPE.BLOCK:
			for value in Global.BLOCKMODE:
				add_item (ToStringHelp.mode_to_string(Global.TYPE.BLOCK,Global.BLOCKMODE[value]), Global.BLOCKMODE[value])
		Global.TYPE.LANG:
			for value in Global.LANGMODE:
				add_item (ToStringHelp.mode_to_string(Global.TYPE.LANG,Global.LANGMODE[value]), Global.LANGMODE[value])
		Global.TYPE.CLASS:
			print("PTDRRRRRRR")
			for value in Global.CLASSGENMODE:
				add_item (ToStringHelp.mode_to_string(Global.TYPE.CLASS,Global.CLASSGENMODE[value]), Global.CLASSGENMODE[value])
	

