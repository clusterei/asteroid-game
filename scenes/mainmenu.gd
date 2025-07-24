extends Control

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("music")
@onready var EVENTSOUND_BUS_ID = AudioServer.get_bus_index("eventsounds")

func _on_mastervolume_drag_ended(_value_changed):
	var value = $VBoxContainer/Mastervolume.value
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < .05)
func _on_musicvolume_drag_ended(_value_changed):
	var value = $VBoxContainer/Musicvolume.value
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)
func _on_sf_xvolume_drag_ended(_value_changed):
	var value = $VBoxContainer/SFXvolume.value
	AudioServer.set_bus_volume_db(EVENTSOUND_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(EVENTSOUND_BUS_ID, value < .05)

func _on_classic_button_button_up() -> void:
	Global_script._update_highscore_stuff("classic")
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_custom_button_button_up() -> void:
	Global_script._update_highscore_stuff("custom")
	get_tree().change_scene_to_file("res://scenes/custom_menu.tscn")

func _on_d_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main_3d.tscn")
