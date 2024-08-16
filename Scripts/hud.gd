extends CanvasLayer

@export var player : Player  
#@onready var health_label: Label = $health
@onready var health_label: Label = $Healt
@onready var interact_label: Label = $Interact


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("player_take_damage", Callable(self, "_on_player_take_damage"))
	player.connect("player_is_dead", Callable(self, "_on_player_is_dead"))
	update_healt_text(player.current_health)
	#interact.text = "interact"
	for node in Utils.get_all_nodes():
		if node is Killzone:
			print("connecting to killzone")
			node.connect("player_entered_killzone", Callable(self, "_on_player_entered_killzone"))
		if node is InteractiveArea:
			print("connecting to interactive area")
			node.connect("is_inside_area", Callable(self, "_on_interactive_area_is_inside_area"))
	
func _process(delta: float) -> void:
	#player.get_node(Camera2D).
	pass

func _on_player_take_damage(damage: int) -> void:
	update_healt_text(player.current_health)
		
func _on_player_is_dead() -> void:
	update_healt_text(player.current_health)

func update_healt_text(current_healt: int):
	health_label.text = str(current_healt) + "HP"
	
func _on_interactive_area_is_inside_area(is_inside,elementInteraction):
	if is_inside:
		interact_label.text = "interact with 'E'"
	else:
		interact_label.text = ""
