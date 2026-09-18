extends Control
class_name MainMenuScreen

signal navigate(screen:String)

const BG = preload("res://assets/ui/main_menu/menu_background.svg")
const LOGO = preload("res://assets/ui/main_menu/logo_emblem.svg")

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var bg = TextureRect.new()
	bg.texture = BG
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	var shade = ColorRect.new()
	shade.color = Color(0.02,0.03,0.035,0.30)
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(shade)

	var root = MarginContainer.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_theme_constant_override("margin_left",88)
	root.add_theme_constant_override("margin_right",88)
	root.add_theme_constant_override("margin_top",54)
	root.add_theme_constant_override("margin_bottom",54)
	add_child(root)

	var row = HBoxContainer.new()
	row.add_theme_constant_override("separation",72)
	root.add_child(row)

	var left = VBoxContainer.new()
	left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	left.alignment = BoxContainer.ALIGNMENT_CENTER
	row.add_child(left)

	var logo = TextureRect.new()
	logo.texture = LOGO
	logo.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	logo.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	logo.custom_minimum_size = Vector2(760,390)
	left.add_child(logo)

	var desc = Label.new()
	desc.text = "Efsanen kazınmış taşta değil, verdiğin kararlarda yaşayacak."
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.custom_minimum_size = Vector2(720,72)
	desc.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	desc.add_theme_font_size_override("font_size",22)
	desc.add_theme_color_override("font_color",Color("#c7b89e"))
	left.add_child(desc)

	var menu_panel = PanelContainer.new()
	menu_panel.custom_minimum_size = Vector2(510,0)
	menu_panel.add_theme_stylebox_override("panel", ThemeFactory.box(Color(0.03,0.05,0.06,0.72), Color("#6e4b24"), 2, 12))
	row.add_child(menu_panel)

	var menu_margin = MarginContainer.new()
	menu_margin.add_theme_constant_override("margin_left",34)
	menu_margin.add_theme_constant_override("margin_right",34)
	menu_margin.add_theme_constant_override("margin_top",38)
	menu_margin.add_theme_constant_override("margin_bottom",28)
	menu_panel.add_child(menu_margin)

	var menu = VBoxContainer.new()
	menu.alignment = BoxContainer.ALIGNMENT_CENTER
	menu.add_theme_constant_override("separation",12)
	menu_margin.add_child(menu)

	_add_menu_button(menu,"DEVAM ET","hud")
	_add_menu_button(menu,"YENİ OYUN","character")
	_add_menu_button(menu,"ENVANTER","inventory")
	_add_menu_button(menu,"GÖREVLER","quests")
	_add_menu_button(menu,"DÜNYA HARİTASI","map")
	_add_menu_button(menu,"SAVAŞ DEMOSU","combat")
	_add_menu_button(menu,"DİYALOG DEMOSU","dialogue")

	var footer = Label.new()
	footer.text = "HER YOL BİR HİKÂYEYE ÇIKAR..."
	footer.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	footer.add_theme_font_size_override("font_size",15)
	footer.add_theme_color_override("font_color",ThemeFactory.GOLD_DARK)
	menu.add_child(footer)

func _add_menu_button(parent:Control, text_value:String, target:String) -> void:
	var b = GameButton.new()
	b.text = text_value
	b.custom_minimum_size = Vector2(440,64)
	b.add_theme_font_size_override("font_size",22)
	b.pressed.connect(func(): navigate.emit(target))
	parent.add_child(b)
