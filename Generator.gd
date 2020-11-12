class_name Generator
extends Node


func _ready():
	pass

#ITEM GEN
static func gen_item_model(item: String) -> String:
	var text: String
	text = """{
	\"parent\": \"item/generated\",
	\"textures\": {
		\"layer0\": \""""+Global.MOD_ID+""":items/"""+item+"""\"
  }
}"""
	return text



#BLOCK GEN
static func gen_block_model(block: String,mode:int) -> String:
	if mode <= -1 :
		Global.handle_error("invalid Mode")
		assert(false)
	var text: String
	
	match mode:
		0:
			text = """{
  \"parent\": \"minecraft:block/cube_all\",
  \"textures\": {
	\"all\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
  }
}"""
		1:
			text = """{
  \"parent\": \"minecraft:block/cube_column\",
  \"textures\": {
	\"end\": \""""+Global.MOD_ID+""":block/"""+block+"""_top\",
	\"side\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
  }
}"""
		2:
			text ="""{
  \"parent\": \"minecraft:block/cross\",
  \"textures\": {
	\"cross\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
  }
}"""
		3:
			text ="""{
  \"parent\": \"minecraft:block/template_anvil\",
  \"textures\": {
	\"top\": \""""+Global.MOD_ID+""":block/"""+block+"""_top\",
	\"body\": \""""+Global.MOD_ID+""":block/"""+block+"""_base\"
  }
}"""
	
	return text

static func gen_itemblock_model(block: String,mode:int) -> String:
	if mode <= -1 :
		Global.handle_error("invalid Mode")
		assert(false)
	var text: String
	
	
	text = """{
  \"parent\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
}"""
	return text

static func gen_blockstate(block: String,mode:int) -> String:
	if mode <= -1 :
		Global.handle_error("invalid Mode")
		assert(false)
	var text: String
	
	match mode:
		0,2:text = """{
  \"variants\": {
	\"\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
	}
  }
}"""
		1:
			text = """{
  \"variants\": {
	\"axis=x\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"x\": 90,
	  \"y\": 90
	},
	\"axis=y\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
	},
	\"axis=z\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"x\": 90
	}
  }
}"""
		3:
			text = """{
  \"variants\": {
	\"facing=east\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"y\": 270
	},
	\"facing=north\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"y\": 180
	},
	\"facing=south\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\"
	},
	\"facing=west\": {
	  \"model\": \""""+Global.MOD_ID+""":block/"""+block+"""\",
	  \"y\": 90
	}
  }
}"""
	
	return text

static func gen_block_texture(block: String,mode:int,size:Vector2 = Vector2(16,16)):
	match mode :
		0,2:
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block,size)
		1:
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block+"_top",size)
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block,size)
		3:
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block+"_top",size)
			Imager.save_empty_png("src/main/resources/assets/"+Global.MOD_ID+"/textures/block/"+block+"_base",size)
	
