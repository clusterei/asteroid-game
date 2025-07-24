extends CanvasLayer

var image = load("res://grafics/playership.png")#totourial said static var ...

func _set_health(health):
	# remove all children
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	# create new amount of children
	for i in health:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$MarginContainer2/HBoxContainer.add_child(text_rect)
		#text_rect.stretch_mode = TextureRect.STRETCH_KEEP#not necessary I believe


func _on_scoretimer_timeout():
	Global_script.score += 1
	$MarginContainer/score.text = Global_script.num_to_time(Global_script.score)
