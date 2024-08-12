extends CharacterBody2D

@onready var npc_collision: CollisionShape2D = $NpcCollision
@onready var level_controller: Node = %LevelController
@onready var interactivity_area: Area2D = $interactivityArea

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#func _process(delta: float) -> void:
	#pass

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

func _on_interactivity_area_body_entered(body: Node2D) -> void:
	level_controller.enable_interactive_area(true, self)


func _on_interactivity_area_body_exited(body: Node2D) -> void:
	level_controller.enable_interactive_area(false, null)
