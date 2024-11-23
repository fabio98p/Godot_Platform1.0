extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var skeletron_container: Node2D = $SkeletronContainer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	animation_player.play("Idle");

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		animation_player.play("Walk");
		velocity.x = direction * SPEED
		if direction > 0:
			skeletron_container.scale.x = 1
		else:
			skeletron_container.scale.x = -1
	else:
		animation_player.play("Idle");
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
