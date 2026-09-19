extends Control
class_name CombatScreen

signal navigate(screen:String)
var enemy_hp:=57
var player_hp:=204
var enemy_bar:StatBar
var player_bar:StatBar
var log_label:Label

func _ready()->void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var bg=ColorRect.new(); bg.color=Color("#0a0e10"); bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); add_child(bg)
	var title=Label.new(); title.text="SAVAŞ · TUR 2"; title.position=Vector2(0,30); title.size=Vector2(1920,60); title.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; title.add_theme_font_size_override("font_size",36); add_child(title)
	var back=GameButton.new(); back.text="‹ MENÜ"; back.position=Vector2(40,28); back.custom_minimum_size=Vector2(150,56); back.pressed.connect(func():navigate.emit("menu")); add_child(back)

	var player=GamePanel.new(); player.position=Vector2(80,120); player.size=Vector2(650,170); add_child(player)
	var pv=HBoxContainer.new(); player.add_child(pv)
	var portrait=Label.new(); portrait.text="♞"; portrait.custom_minimum_size=Vector2(120,120); portrait.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; portrait.add_theme_font_size_override("font_size",70); pv.add_child(portrait)
	var pstats=VBoxContainer.new(); pv.add_child(pstats)
	var pn=Label.new(); pn.text="Aydın · Demir Muhafız"; pn.add_theme_font_size_override("font_size",24); pstats.add_child(pn)
	player_bar=StatBar.new().setup("CAN 204 / 204",204,204,ThemeFactory.RED); pstats.add_child(player_bar)
	pstats.add_child(StatBar.new().setup("MANA 88 / 100",88,100,ThemeFactory.BLUE))

	var enemy=GamePanel.new(); enemy.position=Vector2(1190,120); enemy.size=Vector2(650,170); add_child(enemy)
	var ev=HBoxContainer.new(); enemy.add_child(ev)
	var estats=VBoxContainer.new(); estats.size_flags_horizontal=Control.SIZE_EXPAND_FILL; ev.add_child(estats)
	var en=Label.new(); en.text="Goblin Muhafız"; en.horizontal_alignment=HORIZONTAL_ALIGNMENT_RIGHT; en.add_theme_font_size_override("font_size",24); estats.add_child(en)
	enemy_bar=StatBar.new().setup("CAN 57 / 120",57,120,ThemeFactory.RED); estats.add_child(enemy_bar)
	var eportrait=Label.new(); eportrait.text="☠"; eportrait.custom_minimum_size=Vector2(120,120); eportrait.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; eportrait.add_theme_font_size_override("font_size",70); ev.add_child(eportrait)

	var arena=GamePanel.new(); arena.position=Vector2(250,330); arena.size=Vector2(1420,390); add_child(arena)
	log_label=Label.new(); log_label.text="Aydın kılıcını çekti. Goblin savunmaya geçti."; log_label.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; log_label.vertical_alignment=VERTICAL_ALIGNMENT_CENTER; log_label.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART; log_label.add_theme_font_size_override("font_size",32); arena.add_child(log_label)

	var actions=HBoxContainer.new(); actions.position=Vector2(340,790); actions.add_theme_constant_override("separation",18); add_child(actions)
	_add_action(actions,"⚔\nSALDIR",_attack)
	_add_action(actions,"✦\nYETENEK",_skill)
	_add_action(actions,"⛨\nSAVUN",_guard)
	_add_action(actions,"●\nEŞYA",_item)
	_add_action(actions,"↩\nKAÇ",func():navigate.emit("hud"))

func _add_action(parent:Control,t:String,call:Callable)->void:
	var b=GameButton.new(); b.text=t; b.custom_minimum_size=Vector2(230,120); b.pressed.connect(call); parent.add_child(b)

func _attack()->void:
	enemy_hp=max(0,enemy_hp-18); enemy_bar.set_value(enemy_hp); log_label.text="Kılıç darbesi 18 hasar verdi."
func _skill()->void:
	enemy_hp=max(0,enemy_hp-27); enemy_bar.set_value(enemy_hp); log_label.text="Kalkan Darbesi! 27 hasar ve sersemletme."
func _guard()->void:
	log_label.text="Savunma duruşu: bir sonraki hasar yarıya düşer."
func _item()->void:
	player_hp=min(204,player_hp+24); player_bar.set_value(player_hp); log_label.text="Can iksiri kullanıldı: +24 HP."
