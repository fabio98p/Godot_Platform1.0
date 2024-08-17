class_name Killzone
extends Area2D

signal player_entered_killzone

func _ready() -> void:
	# connect with nedeed signals
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_entered_killzone.emit()
		print("you died")
