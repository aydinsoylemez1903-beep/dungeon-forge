extends Control
class_name MainMenuScreen

signal navigate(screen:String)

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var bg = ColorRect.new()
	bg.color = Color("#080d10")
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	var vignette = PanelContainer.new()
	vignette.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	vignette.add_theme_stylebox_override("panel", ThemeFactory.box(Color(0.03,0.05,0.06,0.82), Color("#39291c"), 2, 0))
	add_child(vignette)

	var root = MarginContainer.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_theme_constant_override("margin_left",100)
	root.add_theme_constant_override("margin_right",100)
	root.add_theme_constant_override("margin_top",70)
	root.add_theme_constant_override("margin_bottom",70)
	add_child(root)

	var row = HBoxContainer.new()
	row.add_theme_constant_override("separation",80)
	root.add_child(row)

	var left = VBoxContainer.new()
	left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	left.alignment = BoxContainer.ALIGNMENT_CENTER
	row.add_child(left)

	var kicker = Label.new()
	kicker.text = "KARANLIK FANTEZİ ROL YAPMA OYUNU"
	kicker.add_theme_color_override("font_color",ThemeFactory.GOLD)
	kicker.add_theme_font_size_override("font_size",18)
	left.add_child(kicker)

	var title = Label.new()
	title.text = "DUNGEON\nFORGE"
	title.add_theme_font_size_override("font_size",92)
	title.add_theme_color_override("font_color",Color("#ead6ac"))
	left.add_child(title)

	var desc = Label.new()
	desc.text = "Efsanen kazınmış taşta değil, verdiğin kararlarda yaşayacak."
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.custom_minimum_size = Vector2(650,80)
	desc.add_theme_color_override("font_color",ThemeFactory.MUTED)
	left.add_child(desc)

	var menu = VBoxContainer.new()
	menu.custom_minimum_size = Vector2(420,0)
	menu.alignment = BoxContainer.ALIGNMENT_CENTER
	menu.add_theme_constant_override("separation",14)
	row.add_child(menu)

	_add_menu_button(menu,"DEVAM ET","hud")
	_add_menu_button(menu,"YENİ OYUN","character")
	_add_menu_button(menu,"ENVANTER","inventory")
	_add_menu_button(menu,"GÖREVLER","quests")
	_add_menu_button(menu,"DÜNYA HARİTASI","map")
	_add_menu_button(menu,"SAVAŞ DEMOSU","combat")
	_add_menu_button(menu,"DİYALOG DEMOSU","dialogue")

	var footer = Label.new()
	footer.text = "FORGE YOUR LEGEND"
	footer.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	footer.add_theme_color_override("font_color",ThemeFactory.GOLD_DARK)
	menu.add_child(footer)

func _add_menu_button(parent:Control, text_value:String, target:String) -> void:
	var b = GameButton.new()
	b.text = text_value
	b.custom_minimum_size = Vector2(420,66)
	b.pressed.connect(func(): navigate.emit(target))
	parent.add_child(b)
