extends Control
class_name WorldMapScreen

signal navigate(screen:String)

func _ready()->void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var root=VBoxContainer.new(); root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); root.offset_left=50; root.offset_top=36; root.offset_right=-50; root.offset_bottom=-36; root.add_theme_constant_override("separation",16); add_child(root)
	var top=HBoxContainer.new(); root.add_child(top)
	var back=GameButton.new(); back.text="‹ MENÜ"; back.custom_minimum_size=Vector2(160,56); back.pressed.connect(func():navigate.emit("menu")); top.add_child(back)
	var title=Label.new(); title.text="DÜNYA HARİTASI"; title.size_flags_horizontal=Control.SIZE_EXPAND_FILL; title.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; title.add_theme_font_size_override("font_size",42); top.add_child(title)
	var coords=Label.new(); coords.text="X: 23   Y: 17"; coords.custom_minimum_size=Vector2(180,56); coords.horizontal_alignment=HORIZONTAL_ALIGNMENT_RIGHT; coords.add_theme_color_override("font_color",ThemeFactory.GOLD); top.add_child(coords)
	var tabs=HBoxContainer.new(); tabs.alignment=BoxContainer.ALIGNMENT_CENTER; root.add_child(tabs)
	for t in ["BÖLGELER","ZİNDANLAR","ŞEHİRLER","ÖZEL"]:
		var b=GameButton.new(); b.text=t; b.custom_minimum_size=Vector2(220,54); tabs.add_child(b)
	var map=GamePanel.new(); map.size_flags_vertical=Control.SIZE_EXPAND_FILL; root.add_child(map)
	var area=Control.new(); area.custom_minimum_size=Vector2(0,780); map.add_child(area)
	var parchment=ColorRect.new(); parchment.color=Color("#8b7a57"); parchment.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); area.add_child(parchment)
	var shade=ColorRect.new(); shade.color=Color("#13202088"); shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); area.add_child(shade)
	var routes=Label.new(); routes.text="╭──────────╮       ╭───────╮\n│ KUZEY    ├───────┤ KARA  │\n│ ORMANLARI│   ◆   │ DAĞLAR│\n╰────┬─────╯       ╰──┬────╯\n     │      ╭─────────╯\n  ╭──┴──╮   │\n  │ ÇÖL ├───┼────◆ KADİM MAĞARA\n  │ ŞEHRİ│  │\n  ╰─────╯   ╰────────🔥 EJDERHA TEPESİ"; routes.position=Vector2(260,150); routes.add_theme_font_size_override("font_size",34); routes.add_theme_color_override("font_color",Color("#20170f")); area.add_child(routes)
	_add_pin(area,"Kuzey Ormanları",Vector2(290,165))
	_add_pin(area,"Kara Dağlar",Vector2(1260,175))
	_add_pin(area,"Kadim Mağara",Vector2(1010,480))
	_add_pin(area,"Çöl Şehri",Vector2(310,520))
	_add_pin(area,"Ejderha Tepesi",Vector2(880,670))

func _add_pin(parent:Control,label_text:String,pos:Vector2)->void:
	var b=GameButton.new(); b.text="◆ "+label_text; b.position=pos; b.custom_minimum_size=Vector2(260,56); parent.add_child(b)
