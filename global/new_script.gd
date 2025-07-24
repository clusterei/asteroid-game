extends Node

var settings_array: Array = ["N", "N", "N", "N"]

var score : int
var destroyed_meteors : int
var highscore := 0
var meteor_highscore := 0
var highscore_savefile_path: String

func _update_highscore_stuff(mode):
	if mode == "classic":
		highscore_savefile_path = "res://highscores_classic.save"
	elif mode == "custom":
		highscore_savefile_path = "res://highscores_custom.save"
		
	if FileAccess.file_exists(highscore_savefile_path):
		var file = FileAccess.open(highscore_savefile_path, FileAccess.READ)
		highscore = file.get_var()
		meteor_highscore = file.get_var()

func num_to_time(s: int) -> String:
	var h: int = int(s / 3600.)
	s %= 3600
	var m: int = int(s / 60.)
	s %= 60
	var string := ""
	if h != 0: string += str(h) + "h "
	if m != 0: string += str(m) + "m "
	if s != 0: string += str(s) + "s "
	return string
