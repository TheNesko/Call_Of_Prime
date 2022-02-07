extends Node


var ItemFiles = []

func _ready():
	var dir = Directory.new()
	dir.open("res://Bin/Scripts/Items/ItemData")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			ItemFiles.append(file)
	dir.list_dir_end()
	prints(ItemFiles)

func _Get_Item_Data(id:int):
	print(ItemFiles.size())
	if ItemFiles.size() <= id: return null
	var ItemPath = "res://Bin/Scripts/Items/ItemData/"
	return load(ItemPath+ItemFiles[id])
