extends CharacterBody2D

var max_health: int = 100
var current_health: int = max_health

@onready var hud: Camera2D = $HUD


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

func _process(delta: float) -> void:
	hud.get_node("health").text = str(current_health) + " HP"
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		current_health -= 5
