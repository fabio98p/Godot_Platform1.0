extends Control


@onready var resolution_option_button: OptionButton = $Panel/HBoxContainer/VBoxContainer/OptionButton

func _ready() -> void:
	add_resolutions()
	var default_resolution = Gui.resolutons.keys().find("1024x600")
	_on_option_button_item_selected(default_resolution)

func add_resolutions():
	for r in Gui.resolutons:
		resolution_option_button.add_item(r)

func update_button_values():
	var windows_size_string = str(get_window().size.x, "x", get_window().size.y)
	var resolution_index = Gui.resolutons.keys().find(windows_size_string)
	resolution_option_button.selected = resolution_index

func _on_option_button_item_selected(index: int) -> void:
	var key = resolution_option_button.get_item_text(index)
	get_window().set_size(Gui.resolutons[key])
	Gui.center_windows()
