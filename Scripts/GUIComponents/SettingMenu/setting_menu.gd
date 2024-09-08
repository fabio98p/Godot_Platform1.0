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

func update_zoom_scale(old_resolution: Vector2i, new_resolution: Vector2i):
	# Calcola il nuovo zoom in base alla risoluzione di riferimento
	var zoom_factor_x = new_resolution.x / float(old_resolution.x)
	var zoom_factor_y = new_resolution.y / float(old_resolution.y)
	for node in Utils.get_all_nodes():
		if node is Camera2D:
			node.zoom.x = node.zoom.x * zoom_factor_x
			node.zoom.y = node.zoom.y * zoom_factor_y

func update_gui_scale(old_resolution: Vector2i, new_resolution: Vector2i):
	var zoom_factor_x = new_resolution.x / float(old_resolution.x)
	var zoom_factor_y = new_resolution.y / float(old_resolution.y)
	#var final_zoom_factor = ( zoom_factor_x + zoom_factor_y ) / 2
	for node in Utils.get_all_nodes():
		if node is Game_Hud:
			node.scale.x = node.scale.x * zoom_factor_x
			node.scale.y = node.scale.y * zoom_factor_y
	
func _on_option_button_item_selected(index: int) -> void:
	var key = resolution_option_button.get_item_text(index)
	update_zoom_scale(get_window().size, Gui.resolutons[key])
	update_gui_scale(get_window().size, Gui.resolutons[key])
	get_window().set_size(Gui.resolutons[key])
	Gui.center_windows()
