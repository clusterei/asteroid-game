extends Control

var selected_index := 0
	
func _on_start_button_button_down():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	
func _on_option_button_item_selected(index):
	selected_index = index
	
func _on_input_focus_exited():
	Global_script.settings_array[selected_index] = $input.text

func _on_highscore_reset_button_button_down():
	DirAccess.remove_absolute(Global_script.highscore_savefile_path)
