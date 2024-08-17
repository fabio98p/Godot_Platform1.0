extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const npc_name = "gino"

func _ready() -> void:
	for child in get_children():
		if child is InteractiveArea:
			child.connect("is_inside_area", Callable(self, "_on_interactive_area_is_inside_area"))

func _physics_process(delta: float) -> void:
	# Add the gravity.
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func start_interaction():
	print("dialugue start correctly")
