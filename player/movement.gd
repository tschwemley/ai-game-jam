extends CharacterBody2D


const SPEED = 205.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") / 20
var gravity = 0

#func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
func _physics_process(delta):
	if Input.is_action_pressed("goDown") or Input.is_action_pressed("goUp"):
		var y_direction = Input.get_axis("goDown", "goUp")
		if y_direction:
			#in the event we are already moving in the x direction with full speed 
			#this will renormalize the total speed.
			if abs(velocity.x) > SPEED / sqrt(2):
				velocity.y= -y_direction * SPEED / sqrt(2)
				velocity.x = sign(velocity.x) * SPEED / sqrt(2)
			else:
				velocity.y = -y_direction * SPEED
	if Input.is_action_pressed("goLeft") or Input.is_action_pressed("goRight"):
		var x_direction = Input.get_axis("goLeft", "goRight")
		if x_direction:
			#in the event we are already moving in the y direction 
			#this will renormalize the total speed.
			if abs(velocity.y) > SPEED / sqrt(2):
				velocity.x= x_direction * SPEED / sqrt(2)
				velocity.y = sign(velocity.y) * SPEED / sqrt(2)
			else:
				velocity.x = x_direction * SPEED
	if Input.is_action_pressed("stop"):
		velocity.x = 0
		velocity.y = 0
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	

