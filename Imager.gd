extends Node
var target_viewport : Viewport
#onready var target_viewport = get_node(viewport_path) if viewport_path else get_tree().root.get_viewport()

func _ready():
	target_viewport = Viewport.new()
	target_viewport.disable_3d = true
	target_viewport.size = Vector2(16,16)

func save_empty_png(path:String,size:Vector2 = Vector2(16,16)):
	target_viewport.size = size
	path = Global.gen_path+path+".png"
	var dir = Directory.new()
	if !dir.dir_exists(path.get_base_dir()):
		dir.make_dir_recursive(path.get_base_dir())
	var img = target_viewport.get_texture().get_data()
	return img.save_png(path)
