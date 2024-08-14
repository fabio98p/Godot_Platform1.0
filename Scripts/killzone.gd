class_name Killzone
extends Area2D

signal player_entered_killzone

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	player_entered_killzone.emit()
	print("you died")
