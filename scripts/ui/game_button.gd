extends Button
class_name GameButton

@export var active_state := false

func _ready() -> void:
	custom_minimum_size = Vector2(260, 64)
	focus_mode = Control.FOCUS_ALL
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	apply_state()

func set_active(value:bool) -> void:
	active_state = value
	apply_state()

func apply_state() -> void:
	if active_state:
		add_theme_stylebox_override("normal", ThemeFactory.button_box("active"))
	else:
		remove_theme_stylebox_override("normal")
