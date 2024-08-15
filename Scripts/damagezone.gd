class_name Damagezone
extends Area2D

signal player_entered_damagezone

@export var damage_value := 5

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	player_entered_damagezone.emit(damage_value)
	print("you take damage")
