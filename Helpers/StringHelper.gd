class_name StringHelper
extends Object




static func name_to_class(objname:String) -> String:
	objname = objname.capitalize()
	var i : int = 0
	var count = objname.count(" ")
	while i <= count:
		objname.erase(objname.find(" "),1)
		i+=1
	return objname

static func path_to_package(path:String) -> String:
	path.erase(0,path.find("/java/")+6)
	var i = 0
	var count = path.count("/")
	while i <= count:
		var j = path.find("/")
		path.erase(j,1)
		path = path.insert(j,".")
		
		i+=1
	if path.ends_with("."):
		path.erase(path.length()-1,1)
	return path

static func standardize_folder_path(path:String) -> String:
	if path.ends_with("/"):
		return path
	else:
		path = path.insert(path.length(),"/")
		return path

static func remove_filename_from_path(path:String) -> String :
	print(path)
	if path.ends_with("/"):
		return path
	var pos = path.find_last("/")+1
	path.erase(pos,path.length()-pos)
	print(path)
	return path
