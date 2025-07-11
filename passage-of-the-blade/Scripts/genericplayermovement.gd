extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = input_vector * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
