extends Control
class_name HudScreen

signal navigate(screen:String)

func _ready()->void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var bg=ColorRect.new(); bg.color=Color("#0b1012"); bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); add_child(bg)
	var center=Label.new(); center.text="KADİM MAĞARA\n\nKaranlık koridorların derinliklerinde eski bir kapı seni bekliyor."; center.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; center.vertical_alignment=VERTICAL_ALIGNMENT_CENTER; center.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART; center.set_anchors_and_offsets_preset(Control.PRESET_CENTER); center.position=Vector2(-360,-120); center.size=Vector2(720,240); center.add_theme_font_size_override("font_size",34); center.add_theme_color_override("font_color",Color("#b9aa91")); add_child(center)

	var top=HBoxContainer.new(); top.position=Vector2(34,28); top.size=Vector2(1852,110); add_child(top)
	var portrait=PanelContainer.new(); portrait.custom_minimum_size=Vector2(330,104); portrait.add_theme_stylebox_override("panel",ThemeFactory.panel_box()); top.add_child(portrait)
	var p=HBoxContainer.new(); portrait.add_child(p)
	var face=Label.new(); face.text="♞"; face.custom_minimum_size=Vector2(74,74); face.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; face.add_theme_font_size_override("font_size",48); p.add_child(face)
	var stats=VBoxContainer.new(); p.add_child(stats)
	var name=Label.new(); name.text="Aydın · Sv. 12"; name.add_theme_font_size_override("font_size",22); stats.add_child(name)
	stats.add_child(StatBar.new().setup("CAN 204 / 204",204,204,ThemeFactory.RED))
	stats.add_child(StatBar.new().setup("MANA 88 / 100",88,100,ThemeFactory.BLUE))
	var spacer=Control.new(); spacer.size_flags_horizontal=Control.SIZE_EXPAND_FILL; top.add_child(spacer)
	var gold=Label.new(); gold.text="◉ 1.245"; gold.add_theme_color_override("font_color",ThemeFactory.GOLD); gold.add_theme_font_size_override("font_size",26); top.add_child(gold)
	var menu=GameButton.new(); menu.text="MENÜ"; menu.custom_minimum_size=Vector2(150,58); menu.pressed.connect(func():navigate.emit("menu")); top.add_child(menu)

	var left=VBoxContainer.new(); left.position=Vector2(36,185); left.add_theme_constant_override("separation",14); add_child(left)
	for pair in [["⚔","combat"],["▣","quests"],["▦","inventory"],["⌖","map"]]:
		var b=GameButton.new(); b.text=pair[0]; b.custom_minimum_size=Vector2(72,72); b.pressed.connect(func(target=pair[1]):navigate.emit(target)); left.add_child(b)

	var mini=PanelContainer.new(); mini.position=Vector2(1540,170); mini.size=Vector2(330,260); mini.add_theme_stylebox_override("panel",ThemeFactory.panel_box()); add_child(mini)
	var ml=Label.new(); ml.text="KUZEY MAĞARASI\n\n   ◉────╮\n  ╭┘  ◆ │\n  │ ◆───╯\n  ╰──◉\n\nX:23   Y:17"; ml.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; ml.vertical_alignment=VERTICAL_ALIGNMENT_CENTER; ml.add_theme_color_override("font_color",ThemeFactory.GOLD); mini.add_child(ml)

	var actions=HBoxContainer.new(); actions.position=Vector2(1180,820); actions.add_theme_constant_override("separation",18); add_child(actions)
	for a in ["⚔","✦","🔥","◉"]:
		var b=GameButton.new(); b.text=a; b.custom_minimum_size=Vector2(118,118); b.add_theme_font_size_override("font_size",42); actions.add_child(b)

	var joystick=PanelContainer.new(); joystick.position=Vector2(55,790); joystick.size=Vector2(160,160); joystick.add_theme_stylebox_override("panel",ThemeFactory.box(Color("#0d1316aa"),Color("#6c5636"),2,80)); add_child(joystick)
	var joy=Label.new(); joy.text="●"; joy.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; joy.vertical_alignment=VERTICAL_ALIGNMENT_CENTER; joy.add_theme_font_size_override("font_size",70); joy.add_theme_color_override("font_color",Color("#7b6a54")); joystick.add_child(joy)
