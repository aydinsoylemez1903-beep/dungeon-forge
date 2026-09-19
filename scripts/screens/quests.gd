extends Control
class_name QuestScreen

signal navigate(screen:String)

func _ready()->void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var root=VBoxContainer.new(); root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); root.offset_left=60; root.offset_top=40; root.offset_right=-60; root.offset_bottom=-40; root.add_theme_constant_override("separation",18); add_child(root)
	var top=HBoxContainer.new(); root.add_child(top)
	var back=GameButton.new(); back.text="‹ MENÜ"; back.custom_minimum_size=Vector2(160,56); back.pressed.connect(func():navigate.emit("menu")); top.add_child(back)
	var title=Label.new(); title.text="GÖREVLER"; title.size_flags_horizontal=Control.SIZE_EXPAND_FILL; title.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; title.add_theme_font_size_override("font_size",42); top.add_child(title)
	var spacer=Control.new(); spacer.custom_minimum_size=Vector2(160,1); top.add_child(spacer)
	var tabs=HBoxContainer.new(); tabs.alignment=BoxContainer.ALIGNMENT_CENTER; root.add_child(tabs)
	for t in ["AKTİF","TAMAMLANAN","BAŞARIMLAR"]:
		var b=GameButton.new(); b.text=t; b.custom_minimum_size=Vector2(260,56); tabs.add_child(b)
	var card=GamePanel.new(); card.size_flags_vertical=Control.SIZE_EXPAND_FILL; root.add_child(card)
	var v=VBoxContainer.new(); v.add_theme_constant_override("separation",18); card.add_child(v)
	var q=Label.new(); q.text="KADİM MAĞARA"; q.add_theme_font_size_override("font_size",34); q.add_theme_color_override("font_color",ThemeFactory.GOLD_BRIGHT); v.add_child(q)
	var body=Label.new(); body.text="Eski bir uygarlığa ait olduğu düşünülen bu mağarada gizli bir kristal saklanıyor.\n\n✓ Mağaraya gir\n✓ İlk odayı temizle\n◐ Kristal parçalarını bul (2/3)\n☐ Boss'u yen"; body.add_theme_font_size_override("font_size",25); body.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART; v.add_child(body)
	var sep=HSeparator.new(); v.add_child(sep)
	var rewards=Label.new(); rewards.text="ÖDÜLLER     XP 500      ◉ 250      ◆ Efsanevi Rün"; rewards.add_theme_color_override("font_color",ThemeFactory.GOLD); rewards.add_theme_font_size_override("font_size",24); v.add_child(rewards)
	for qn in ["Kayıp Kervan","Orman Tehdidi","Kara Dağların Sırrı"]:
		var b=GameButton.new(); b.text=qn+"     ›"; b.custom_minimum_size=Vector2(0,62); v.add_child(b)
