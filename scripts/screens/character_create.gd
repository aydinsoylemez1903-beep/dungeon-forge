extends Control
class_name CharacterCreateScreen

signal navigate(screen:String)

var race := "İnsan"
var class_name_value := "Savaşçı"
var stat_labels := {}
var points := 6
var stats = {"STR":14,"DEX":10,"CON":12,"INT":8,"WIS":10,"CHA":10}

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var margin = MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left",54)
	margin.add_theme_constant_override("margin_right",54)
	margin.add_theme_constant_override("margin_top",42)
	margin.add_theme_constant_override("margin_bottom",42)
	add_child(margin)

	var column=VBoxContainer.new()
	column.add_theme_constant_override("separation",18)
	margin.add_child(column)

	var header=HBoxContainer.new()
	var back=GameButton.new(); back.text="‹ MENÜ"; back.custom_minimum_size=Vector2(160,56); back.pressed.connect(func():navigate.emit("menu"))
	header.add_child(back)
	var title=Label.new(); title.text="KARAKTER OLUŞTUR"; title.size_flags_horizontal=Control.SIZE_EXPAND_FILL
	title.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; title.add_theme_font_size_override("font_size",42)
	header.add_child(title)
	var spacer=Control.new(); spacer.custom_minimum_size=Vector2(160,1); header.add_child(spacer)
	column.add_child(header)

	var body=HBoxContainer.new(); body.size_flags_vertical=Control.SIZE_EXPAND_FILL; body.add_theme_constant_override("separation",22)
	column.add_child(body)

	var portrait=GamePanel.new(); portrait.custom_minimum_size=Vector2(500,0); body.add_child(portrait)
	var pv=VBoxContainer.new(); pv.alignment=BoxContainer.ALIGNMENT_CENTER; portrait.add_child(pv)
	var silhouette=Label.new(); silhouette.text="⚔"; silhouette.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
	silhouette.add_theme_font_size_override("font_size",220); silhouette.add_theme_color_override("font_color",Color("#a87d48")); pv.add_child(silhouette)
	var pname=LineEdit.new(); pname.placeholder_text="Karakter adı"; pname.text="Aydın"; pname.custom_minimum_size=Vector2(360,58); pv.add_child(pname)

	var choices=GamePanel.new(); choices.size_flags_horizontal=Control.SIZE_EXPAND_FILL; body.add_child(choices)
	var cv=VBoxContainer.new(); cv.add_theme_constant_override("separation",16); choices.add_child(cv)
	_section_title(cv,"IRK")
	var races=HBoxContainer.new(); cv.add_child(races)
	for r in ["İnsan","Elf","Cüce","Yark"]:
		var b=GameButton.new(); b.text=r; b.custom_minimum_size=Vector2(150,62); b.pressed.connect(func(v=r): race=v)
		races.add_child(b)
	_section_title(cv,"SINIF")
	var classes=HBoxContainer.new(); cv.add_child(classes)
	for c in ["Savaşçı","Büyücü","Rogue","Rahip"]:
		var b=GameButton.new(); b.text=c; b.custom_minimum_size=Vector2(150,62); b.pressed.connect(func(v=c): class_name_value=v)
		classes.add_child(b)
	_section_title(cv,"ÖZELLİKLER")
	var stats_grid=GridContainer.new(); stats_grid.columns=3; stats_grid.add_theme_constant_override("h_separation",16); stats_grid.add_theme_constant_override("v_separation",12); cv.add_child(stats_grid)
	for key in stats.keys():
		var row=HBoxContainer.new()
		var name=Label.new(); name.text=key; name.custom_minimum_size=Vector2(54,44); row.add_child(name)
		var minus=Button.new(); minus.text="−"; minus.custom_minimum_size=Vector2(44,44); minus.pressed.connect(func(k=key): _change_stat(k,-1)); row.add_child(minus)
		var value=Label.new(); value.text=str(stats[key]); value.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; value.custom_minimum_size=Vector2(46,44); row.add_child(value); stat_labels[key]=value
		var plus=Button.new(); plus.text="+"; plus.custom_minimum_size=Vector2(44,44); plus.pressed.connect(func(k=key): _change_stat(k,1)); row.add_child(plus)
		stats_grid.add_child(row)
	var remain=Label.new(); remain.name="Remaining"; remain.text="Kalan puan: %d"%points; remain.add_theme_color_override("font_color",ThemeFactory.GOLD); cv.add_child(remain)
	var create=GameButton.new(); create.text="KARAKTERİ OLUŞTUR"; create.custom_minimum_size=Vector2(0,72); create.pressed.connect(func():navigate.emit("hud")); cv.add_child(create)

func _section_title(parent:Control,t:String)->void:
	var l=Label.new(); l.text=t; l.add_theme_color_override("font_color",ThemeFactory.GOLD); l.add_theme_font_size_override("font_size",18); parent.add_child(l)

func _change_stat(key:String, delta:int)->void:
	if delta>0 and points<=0:return
	if delta<0 and stats[key]<=8:return
	stats[key]+=delta
	points-=delta
	stat_labels[key].text=str(stats[key])
	var remain=find_child("Remaining",true,false)
	if remain: remain.text="Kalan puan: %d"%points
