extends PanelContainer
class_name GamePanel

@export var title := ""

func _ready() -> void:
	add_theme_stylebox_override("panel", ThemeFactory.panel_box())
