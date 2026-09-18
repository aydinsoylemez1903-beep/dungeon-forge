extends Button
class_name GameButton

@export var active_state := false

const TEX_NORMAL = preload("res://assets/ui/main_menu/button_normal.svg")
const TEX_HOVER = preload("res://assets/ui/main_menu/button_hover.svg")
const TEX_PRESSED = preload("res://assets/ui/main_menu/button_pressed.svg")

func _ready() -> void:
	custom_minimum_size = Vector2(260, 64)
	focus_mode = Control.FOCUS_ALL
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	_apply_visuals()

func set_active(value:bool) -> void:
	active_state = value
	_apply_visuals()

func _style(texture:Texture2D) -> StyleBoxTexture:
	var s = StyleBoxTexture.new()
	s.texture = texture
	s.texture_margin_left = 84
	s.texture_margin_right = 84
	s.texture_margin_top = 28
	s.texture_margin_bottom = 28
	s.content_margin_left = 28
	s.content_margin_right = 28
	s.content_margin_top = 12
	s.content_margin_bottom = 12
	return s

func _apply_visuals() -> void:
	add_theme_stylebox_override("normal", _style(TEX_HOVER if active_state else TEX_NORMAL))
	add_theme_stylebox_override("hover", _style(TEX_HOVER))
	add_theme_stylebox_override("pressed", _style(TEX_PRESSED))
	add_theme_stylebox_override("focus", _style(TEX_HOVER))
	add_theme_color_override("font_color", ThemeFactory.TEXT)
	add_theme_color_override("font_hover_color", Color.WHITE)
	add_theme_color_override("font_pressed_color", ThemeFactory.GOLD_BRIGHT)
