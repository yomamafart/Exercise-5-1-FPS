extends Node


func _unhandled_input(event):
	if event.is_action_pressed("Quit"):
		get_tree().quit()
