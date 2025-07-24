extends Area2D

@export var speed = 100
var rotation_speed: float
var velocity#: float?????
var can_collide := true
signal collision

func _ready():
	var rng := RandomNumberGenerator.new()
	var screendims = get_viewport().get_visible_rect().size
	
	var random_x = rng.randi_range(0, screendims[0])
	var random_y = rng.randi_range(-100, -50)
	var random_scale = rng.randf_range(0.5, 1)
	var dir_angle = rng.randf_range(-1, 1) + PI / 2
	var random_speed = rng.randf_range(0.5, 1.5)
	
	position = Vector2(random_x, random_y)
	scale *= Vector2(random_scale, random_scale)
	velocity = Vector2(cos(dir_angle), sin(dir_angle)) * random_speed * speed
	rotation_speed = rng.randf_range(-0.1, 0.1)

func _process(delta):
	position += velocity * delta
	rotation += rotation_speed * delta

func _on_body_entered(_body):
	if can_collide:
		collision.emit()
		_destroy_meteor()

func _on_area_entered(area):
	if can_collide:
		area.queue_free()
		$explosionsound.play()
		_destroy_meteor()

func _destroy_meteor():
	$meteorimage.hide()
	$explosion_particle.emitting = true
	can_collide = false
	Global_script.destroyed_meteors += 1
	await get_tree().create_timer(1).timeout
	queue_free()
