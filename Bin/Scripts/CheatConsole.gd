extends Control


func _physics_process(_delta):
	if visible == true: get_tree().paused = true
	else: get_tree().paused = false

var PreviousCommand = ""
var WasVisible = false
func _process(_delta):
	if visible == false:
		WasVisible = false
		return
	if WasVisible == false and visible == true:
		$ConsolePanel/TextEdit.grab_focus()
	WasVisible = true
	var ConsoleField = $ConsolePanel/TextEdit
	if Input.is_key_pressed(KEY_UP):
		ConsoleField.text = ""
		ConsoleField.text = PreviousCommand
	if ConsoleField.text != null and Input.is_action_just_pressed("ui_accept"):
		PreviousCommand = ConsoleField.text
		var WrittenCommand = ConsoleField.text.to_lower().split(" ")
		ConsoleField.text = ""
		
		match WrittenCommand[0]:
			"give":
				_Give(int(WrittenCommand[1]))


func _Give(id:int):
	var ItemData = ItemDataBase._Get_Item_Data(id)
	if ItemData == null: return
	var ItemBase = load("res://Bin/Scenes/Items/ItemBase.tscn")
	var ItemCopy = ItemBase.instance()
	ItemCopy.ItemData = ItemData
	get_parent().get_parent().get_parent().add_child(ItemCopy)
	ItemCopy.position = get_parent().Player.position
