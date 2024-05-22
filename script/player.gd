extends CharacterBody2D


var speed :float= 400.0
var acceleration :float= 0.1

@export var on_foot = true
var current_vehicle:CharacterBody2D

func _physics_process(delta: float) -> void:
	#If on foot, do this:
	if on_foot:
		$Camera2D.enabled = true
		$Sprite2D.show()
		$CollisionShape2D.disabled = false
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		input_vector = input_vector.normalized()
		
		velocity = velocity.lerp(input_vector * speed, acceleration)
		move_and_slide()
		look_at(get_global_mouse_position())
	else:
		if current_vehicle!=null:
			$Camera2D.enabled = false
			global_position = current_vehicle.global_position
			$Sprite2D.hide()
			$CollisionShape2D.disabled = false
			

	if Input.is_action_just_pressed("enter_car"):
		if not on_foot:
			on_foot = true
			global_position = current_vehicle.spawn_position.global_position
			current_vehicle = null
		if on_foot:
			$Area2D/CollisionShape2D.disabled = false
			$Area2D/Timer.start()

