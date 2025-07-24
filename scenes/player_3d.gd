extends Node3D

var accel: int = 15
#var ang_accel: int = 2
var velocity := Vector3.ZERO
#var ang_velocity := Vector3.ZERO###make this an option
var stabilising := true
#var turning_inertia_enabled := false

func _process(delta: float) -> void:
	var _basis = transform.basis
	var dir = - _basis.z
	
	var engine_on = Input.is_action_pressed("engine_on")
	#$GPUParticles3D.emitting = engine_on
	if engine_on:
		velocity += dir * accel * delta
	position += velocity * delta
	
	var mouse_dir_v: Vector2 = ($UI.get_local_mouse_position() - Vector2(get_viewport().size) / 2) / min(get_viewport().size.x, get_viewport().size.y)
	var roll: float = float(Input.is_action_pressed("roll_left")) - float(Input.is_action_pressed("roll_right"))
	#var rot_change: Vector3 = Vector3(-mouse_dir_v.y, -mouse_dir_v.x, roll)
	#if turning_inertia_enabled:
	#	ang_velocity += rot_change * ang_accel * delta#####only works when not rolled (right-vector always same, otherwise calc wrong; rollcalc wrong when dir-vector not same it seems)
	#	rotation += ang_velocity * delta
	#else:
	#	rotation += rot_change * delta
	rotate(_basis.y, - mouse_dir_v.x * delta)
	rotate(_basis.x, - mouse_dir_v.y * delta)
	rotate(_basis.z, roll * delta)
	transform.basis.x = transform.basis.x.normalized()
	transform.basis.y = transform.basis.y.normalized()
	transform.basis.z = transform.basis.z.normalized()
	
	if Input.is_action_just_pressed("toggle_stabiliser"):
		stabilising = not stabilising
	
	if stabilising:
		velocity *= 0.99
		#ang_velocity *= 0.99
