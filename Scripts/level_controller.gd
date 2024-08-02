extends Node

@onready var player: CharacterBody2D = %Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_is_dead():
		restart_game()

func player_take_amage(damage: int):
	player.get_damage(damage)

func player_died():
	player.die()
	
func player_is_dead():
	if player.current_health > 0:
		return false
	return true

func restart_game():
	print("restart scene")
