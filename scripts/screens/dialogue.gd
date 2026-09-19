extends Control
class_name DialogueScreen

signal navigate(screen:String)

func _ready()->void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var bg=ColorRect.new(); bg.color=Color("#080c0f"); bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); add_child(bg)
	var portrait=GamePanel.new(); portrait.position=Vector2(90,100); portrait.size=Vector2(620,820); add_child(portrait)
	var pv=VBoxContainer.new(); pv.alignment=BoxContainer.ALIGNMENT_CENTER; portrait.add_child(pv)
	var npc=Label.new(); npc.text="♚"; npc.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; npc.add_theme_font_size_override("font_size",260); npc.add_theme_color_override("font_color",Color("#9c7448")); pv.add_child(npc)
	var name=Label.new(); name.text="TÜCCAR BARAN"; name.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; name.add_theme_font_size_override("font_size",32); name.add_theme_color_override("font_color",ThemeFactory.GOLD); pv.add_child(name)
	var role=Label.new(); role.text="Kadim Mahzen Tüccarı"; role.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; role.add_theme_color_override("font_color",ThemeFactory.MUTED); pv.add_child(role)

	var box=GamePanel.new(); box.position=Vector2(760,150); box.size=Vector2(1060,700); add_child(box)
	var v=VBoxContainer.new(); v.add_theme_constant_override("separation",16); box.add_child(v)
	var line=Label.new(); line.text="Yolun uzun görünüyor, dostum. İhtiyacın olan her şey bu dükkânda olabilir... ama bazı şeylerin bedeli altın değildir."; line.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART; line.custom_minimum_size=Vector2(0,190); line.add_theme_font_size_override("font_size",30); v.add_child(line)
	for choice in ["EŞYALARA BAK","TAKAS YAP","SÖYLENTİLERİ SOR","KONUŞ","AYRIL"]:
		var b=GameButton.new(); b.text=choice; b.custom_minimum_size=Vector2(0,72); 
		if choice=="AYRIL": b.pressed.connect(func():navigate.emit("hud"))
		v.add_child(b)
	var back=GameButton.new(); back.text="‹ MENÜ"; back.position=Vector2(40,28); back.custom_minimum_size=Vector2(150,56); back.pressed.connect(func():navigate.emit("menu")); add_child(back)
