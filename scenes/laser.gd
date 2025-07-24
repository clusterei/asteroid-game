extends Area2D

var velocity

func _ready():
	#$Sprite2D.scale = Vector2(0, 0)#not necessary because of .from(Vector2(0, 0))
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(1, 1), 0.1).from(Vector2(0, 0))

func _process(delta):
	position += velocity * delta
