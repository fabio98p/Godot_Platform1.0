extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# player variable
var max_health: int = 100
var current_health: int = max_health
# movment variable
const SPEED = 200.0
const JUMP_VELOCITY = -300.0
# animation variable
var special_animation_is_running = false # special is : [Roll, Hit, Dead]
var animation_type := "Idle" # [Idle, Run, Jump, Dead, Hit, Roll]
# interaction variable
var interactive_element: Node
var is_inside_interactive_area: bool
#signal
signal player_is_dead
signal player_take_damage

func _ready() -> void:
	#connect to all needed signal
	player_take_damage.connect(Callable(self, "_on_player_take_damage"))
	animated_sprite_2d.animation_finished.connect(Callable(self, "_animation_finished"))
	for node in Utils.get_all_nodes():
		if node is Killzone:
			print("connecting to killzone")
			node.connect("player_entered_killzone", Callable(self, "_on_player_entered_killzone"))
		if node is Damagezone:
			print("connecting to damagezone")
			node.connect("player_entered_damagezone", Callable(self, "_on_player_entered_damagezone"))
		if node is InteractiveArea:
			print("connecting to interactive area")
			node.connect("is_inside_area", Callable(self, "_on_interactive_area_is_inside_area"))
	
#func _process(delta: float) -> void:
	#pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	animation_handler(direction)
	move_and_slide()

func animation_handler(direction):
	# handle special animation
	if Input.is_action_just_pressed("Roll") and is_on_floor():
		special_animation_is_running = true
		animation_type = "Roll"
	
	# handle no special animation
	if !special_animation_is_running:
		if !is_on_floor():
			animation_type = "Jump"
		elif direction:
			animation_type = "Run"
		else:
			animation_type = "Idle"
	
	# handle the direction of the animation
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
	
	animated_sprite_2d.animation = animation_type

func take_damage(damage: int):
	current_health -= damage
	player_take_damage.emit(damage)
	if current_health <= 0:
		player_is_dead.emit()
	
	special_animation_is_running = true
	animation_type = "Roll"

func _animation_finished() -> void:
	special_animation_is_running = false
	animation_type = "Idle"
	animated_sprite_2d.play()

# signal about interactivity
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if is_inside_interactive_area:
			interactive_element.start_interaction()
			
func _on_interactive_area_is_inside_area(is_inside,elementInteraction):
	if is_inside:
		is_inside_interactive_area = true
		interactive_element = elementInteraction
	else:
		is_inside_interactive_area = false
		interactive_element = null

# damage and dead signal
func _on_player_entered_killzone() -> void:
	current_health = 0
	player_is_dead.emit()

func _on_player_entered_damagezone(damage: int) -> void:
	player_take_damage.emit(damage)

func _on_player_is_dead() -> void:
	# change animation with dieing animation
	# play dieing sound
	print("player dieing in player script")

func _on_player_take_damage(damage: int) -> void:
	current_health -= damage
	if current_health <= 0:
		player_is_dead.emit()
	
	special_animation_is_running = true
	animation_type = "Hit"
