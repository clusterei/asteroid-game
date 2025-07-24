extends Node2D


var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var health: int = 5

func _ready():
	var i = -1
	for setting in Global_script.settings_array:
		i += 1
		if setting == "N":
			continue
		if i == 0:
			health = int(setting)
		elif i == 1:
			$spawntimer.wait_time = float(setting)
		elif i == 2:
			$"player/lasercooldown".wait_time = float(setting)
		elif i == 3:
			$player.accelleration = float(setting)
		else:
			print("unknown setting at ", i, ": ", setting)
	
	get_tree().call_group("ui", "_set_health", health)
	Global_script.score = 0
	Global_script.destroyed_meteors = 0

func _on_spawntimer_timeout():
	var meteor = meteor_scene.instantiate()
	$meteors.add_child(meteor)
	#to connect the signal:
	meteor.connect("collision", _on_meteor_collision)

func _on_meteor_collision():
	$player._play_collision_sound()
	health -= 1
	#$UI could be used but there is alternative solution below
	get_tree().call_group("ui", "_set_health", health)
	if health == 0:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/gameover.tscn")

func _on_player_laser(pos, vel, rot):
	var laser = laser_scene.instantiate()
	$lasers.add_child(laser)
	laser.position = pos
	laser.velocity = vel
	laser.rotation = rot


func _on_relevance_dtection_area_area_exited(area):
	area.queue_free()
