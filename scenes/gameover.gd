extends Control

var level_scene: PackedScene = load("res://scenes/level.tscn")#@export can be used to make path editable from inspector

func _ready():
	$final_crash.play()
	
	$CenterContainer/VBoxContainer/score.text += Global_script.num_to_time(Global_script.score)
	$CenterContainer/VBoxContainer/highscore.text += Global_script.num_to_time(Global_script.highscore)
	if Global_script.highscore < Global_script.score:
		Global_script.highscore = Global_script.score
		$CenterContainer/VBoxContainer/highscore.text += " (beaten!)"
		
	$CenterContainer/VBoxContainer/destroyed_meteors.text += str(Global_script.destroyed_meteors)
	$CenterContainer/VBoxContainer/meteor_highscore.text += str(Global_script.meteor_highscore)
	if Global_script.meteor_highscore < Global_script.destroyed_meteors:
		Global_script.meteor_highscore = Global_script.destroyed_meteors
		$CenterContainer/VBoxContainer/meteor_highscore.text += " (beaten!)"
	
	var file = FileAccess.open(Global_script.highscore_savefile_path, FileAccess.WRITE)
	file.store_var(Global_script.highscore)
	file.store_var(Global_script.meteor_highscore)

#func _process(_delta):
#	if Input.is_action_just_pressed("shoot"):
#		#get_tree().change_scene_to_file("res://scenes/level.tscn")#also works
#		get_tree().change_scene_to_packed(level_scene)

func _input(event):
	if event.is_action_pressed("new_game"):
		get_tree().change_scene_to_packed(level_scene)
