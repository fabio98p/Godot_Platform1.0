extends CharacterBody2D

var max_health: int = 100
var current_health: int = max_health

#signal die
#signal take_damage

@onready var hud: Camera2D = $HUD


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

func _ready() -> void:
	# get all nodes
	var nodes_tree = get_tree().get_root()
	var all_nodes = []
	all_nodes.push_back(nodes_tree)
	for child in nodes_tree.get_children():
		all_nodes = get_all_children(child, all_nodes)

	#connect to the killzone signal
	for node in all_nodes:
		if node is Killzone:
			print("connecting to killzone")
			node.connect("player_entered_killzone", Callable(self, "_on_player_entered_killzone"))

func _process(delta: float) -> void:
	hud.get_node("health").text = str(current_health) + " HP"


func get_all_children(in_node, array := []):
	array.push_back(in_node)
	for child in in_node.get_children():
		array = get_all_children(child, array)
	return array

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

func take_damage(damage: int):
	current_health -= damage

#func _on_die():
	#current_health = 0


func _on_player_entered_killzone() -> void:
	print("player is died nowwowowoowowow")
	current_health = 0
