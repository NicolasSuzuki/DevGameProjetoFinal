extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Options_button_up():
	get_tree().change_scene("res://game/scenes/mainMenu/options.tscn")


func _on_Exit_button_up():
	get_tree().quit()

func _on_NewGame_button_up():
	get_tree().change_scene("res://game/scenes/mainMenu/lvl01.tscn")
