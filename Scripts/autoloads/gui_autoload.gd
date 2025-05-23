extends CanvasLayer

var gui_components = [
	"res://Scenes/GUIComponent/SettingMenu/setting_menu.tscn"
]

var resolutons = {
	"3840x2160": Vector2i(3840, 2160),
	"2560x1440": Vector2i(2560, 1440),
	"1920x1080": Vector2i(1920, 1080),
	"1366x768": Vector2i(1366, 768),
	"1280x720": Vector2i(1280, 720),
	"1440x900": Vector2i(1440, 900),
	"1600x900": Vector2i(1600, 900),
	"1024x600": Vector2i(1024, 600),
	"800x600": Vector2i(800, 600),
}

func _ready() -> void:
	for i in gui_components:
		var new_scene = load(i).instantiate()
		add_child(new_scene)
		new_scene.hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_setting"):
		var settings_menu: Control = get_node("SettingMenu")
		settings_menu.visible = !settings_menu.visible
		if settings_menu.visible:
			settings_menu.update_button_values()

func center_windows():
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size /2)
