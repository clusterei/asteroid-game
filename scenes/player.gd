extends CharacterBody2D

@export var accelleration: int = 600#@export makes variable editable in inspector; int specifies type of variable (not necessary)
@export var laserspeed: int = 700
var can_shoot := false
signal laser(pos, vel, rot)
@export var playerfocused_camera: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():#=__init__
	$lasercooldown.start()
	$Camera2D.enabled = playerfocused_camera

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):#=once per frame#replace delta with _delta if its not used
	#var dir_vector = get_global_mouse_position() - position
	#dir_vector /= dir_vector#length
	#position += dir_vector
	#var dir_vector = Input.get_vector("left", "right", "up", "down").normalized()
	#speed += dir_vector * delta * accelleration
	#position += speed * delta
	var engine_on = Input.is_action_pressed("engine_on")
	$GPUParticles2D.emitting = engine_on
	$GPUParticles2D2.emitting = engine_on
	if engine_on:
		velocity += (position - to_global(($GPUParticles2D.position + $GPUParticles2D2.position) / 2)).normalized() * accelleration * delta#velocity is inbuild to considder delta and stuff, still used here to correctly change velocity
	move_and_slide()
	
	if not $Camera2D.enabled:
		rotation = (get_global_mouse_position() - position).angle()
	else:
		rotation += get_local_mouse_position().angle() / 50
	
	$laser_cooldown_bar.value = 1 - $lasercooldown.time_left / $lasercooldown.wait_time
	if Input.is_action_pressed("shoot") and can_shoot:
		can_shoot = false
		$lasercooldown.start()
		
		var pos = to_global($laserspawnpoint.position)
		var vel = velocity + (pos - position).normalized() * laserspeed
		laser.emit(pos, vel, rotation)
		$lasersound.play()
	

func _on_lasercooldown_timeout():
	can_shoot = true
	
func _play_collision_sound():
	$collisionsound.play()
