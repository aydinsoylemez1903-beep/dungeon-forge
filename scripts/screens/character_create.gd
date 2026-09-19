extends Control
class_name CharacterCreateScreen

signal navigate(screen:String)

const MALE_SHORT = preload("res://assets/characters/human_male_short.svg")
const MALE_LONG = preload("res://assets/characters/human_male_long.svg")
const FEMALE_LONG = preload("res://assets/characters/human_female_long.svg")
const FEMALE_BRAID = preload("res://assets/characters/human_female_braid.svg")

var race := "İnsan"
var class_name_value := "Savaşçı"
var gender := "male"
var hair := 0
var selected_tab := "Irk"
var body_scale := 1.0
var preview:TextureRect
var side_content:VBoxContainer
var name_input:LineEdit
var skin_tint := Color.WHITE

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_build_background()
	_build_header()
	_build_layout()
	_refresh_preview()
	_show_tab("Irk")

func _build_background() -> void:
	var bg=ColorRect.new()
	bg.color=Color("#080d10")
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

func _build_header() -> void:
	var header=HBoxContainer.new()
	header.position=Vector2(36,24)
	header.size=Vector2(1848,70)
	add_child(header)
	var back=GameButton.new()
	back.text="‹ GERİ"
	back.custom_minimum_size=Vector2(180,58)
	back.pressed.connect(func():navigate.emit("menu"))
	header.add_child(back)
	var title=Label.new()
	title.text="KARAKTER OLUŞTURMA"
	title.size_flags_horizontal=Control.SIZE_EXPAND_FILL
	title.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size",40)
	header.add_child(title)
	var next=GameButton.new()
	next.text="DEVAM ET ›"
	next.custom_minimum_size=Vector2(220,58)
	next.pressed.connect(_next_tab)
	header.add_child(next)

func _build_layout() -> void:
	var root=HBoxContainer.new()
	root.position=Vector2(36,110)
	root.size=Vector2(1848,930)
	root.add_theme_constant_override("separation",18)
	add_child(root)

	var left=GamePanel.new()
	left.custom_minimum_size=Vector2(390,0)
	root.add_child(left)
	var lv=VBoxContainer.new()
	lv.add_theme_constant_override("separation",10)
	left.add_child(lv)
	for t in ["Irk","Sınıf","Görünüm","İsim","Onay"]:
		var b=GameButton.new()
		b.text=t.to_upper()
		b.custom_minimum_size=Vector2(0,54)
		b.pressed.connect(func(tab=t): _show_tab(tab))
		lv.add_child(b)
	side_content=VBoxContainer.new()
	side_content.size_flags_vertical=Control.SIZE_EXPAND_FILL
	side_content.add_theme_constant_override("separation",10)
	lv.add_child(side_content)

	var center=GamePanel.new()
	center.size_flags_horizontal=Control.SIZE_EXPAND_FILL
	root.add_child(center)
	var cv=VBoxContainer.new()
	cv.alignment=BoxContainer.ALIGNMENT_CENTER
	center.add_child(cv)
	var gender_row=HBoxContainer.new()
	gender_row.alignment=BoxContainer.ALIGNMENT_CENTER
	cv.add_child(gender_row)
	var male=GameButton.new()
	male.text="♂ ERKEK"
	male.custom_minimum_size=Vector2(220,56)
	male.pressed.connect(func(): gender="male"; _refresh_preview())
	gender_row.add_child(male)
	var female=GameButton.new()
	female.text="♀ KADIN"
	female.custom_minimum_size=Vector2(220,56)
	female.pressed.connect(func(): gender="female"; _refresh_preview())
	gender_row.add_child(female)

	preview=TextureRect.new()
	preview.custom_minimum_size=Vector2(760,760)
	preview.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.pivot_offset=Vector2(380,760)
	cv.add_child(preview)

	name_input=LineEdit.new()
	name_input.placeholder_text="Karakter ismi"
	name_input.text="Aydın"
	name_input.custom_minimum_size=Vector2(520,58)
	cv.add_child(name_input)

	var right=GamePanel.new()
	right.custom_minimum_size=Vector2(470,0)
	root.add_child(right)
	var rv=VBoxContainer.new()
	rv.add_theme_constant_override("separation",12)
	right.add_child(rv)
	var rt=Label.new()
	rt.text="GÖRÜNÜM"
	rt.add_theme_color_override("font_color",ThemeFactory.GOLD_BRIGHT)
	rt.add_theme_font_size_override("font_size",26)
	rv.add_child(rt)

	_add_slider(rv,"Vücut Tipi",0.86,1.14,1.0,func(v): body_scale=v; _refresh_preview())
	_add_slider(rv,"Boy",0.92,1.08,1.0,func(v): preview.scale.y=v)

	var hair_title=Label.new()
	hair_title.text="Saç Stili"
	hair_title.add_theme_color_override("font_color",ThemeFactory.GOLD)
	rv.add_child(hair_title)
	var hair_row=HBoxContainer.new()
	rv.add_child(hair_row)
	for i in range(2):
		var hb=GameButton.new()
		hb.text="STİL %d"%(i+1)
		hb.custom_minimum_size=Vector2(150,52)
		hb.pressed.connect(func(idx=i): hair=idx; _refresh_preview())
		hair_row.add_child(hb)

	var skin_label=Label.new()
	skin_label.text="Ten Rengi"
	skin_label.add_theme_color_override("font_color",ThemeFactory.GOLD)
	rv.add_child(skin_label)
	var colors=HBoxContainer.new()
	rv.add_child(colors)
	for c in [Color("#f1d0b5"),Color("#d6a276"),Color("#b77f5a"),Color("#8e5f43"),Color("#5c3b2c")]:
		var sw=Button.new()
		sw.custom_minimum_size=Vector2(54,54)
		sw.add_theme_stylebox_override("normal",ThemeFactory.box(c,c.lightened(.15),2,5))
		sw.pressed.connect(func(col=c): skin_tint=col; _refresh_preview())
		colors.add_child(sw)

	var info=Label.new()
	info.text="Yüz, dövme, zırh ve ek saç katmanları ayrı assetler halinde genişletilecek."
	info.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART
	info.add_theme_color_override("font_color",ThemeFactory.MUTED)
	rv.add_child(info)

func _add_slider(parent:Control,label_text:String,minv:float,maxv:float,val:float,callback:Callable) -> void:
	var l=Label.new()
	l.text=label_text
	parent.add_child(l)
	var s=HSlider.new()
	s.min_value=minv
	s.max_value=maxv
	s.value=val
	s.step=.01
	s.custom_minimum_size=Vector2(0,36)
	s.value_changed.connect(callback)
	parent.add_child(s)

func _show_tab(tab:String) -> void:
	selected_tab=tab
	for c in side_content.get_children():
		c.queue_free()
	var h=Label.new()
	h.text=tab.to_upper()
	h.add_theme_color_override("font_color",ThemeFactory.GOLD_BRIGHT)
	h.add_theme_font_size_override("font_size",22)
	side_content.add_child(h)
	match tab:
		"Irk":
			for r in ["İnsan","Elf","Cüce","Yark"]:
				var b=GameButton.new()
				b.text=r
				b.pressed.connect(func(v=r): race=v)
				side_content.add_child(b)
		"Sınıf":
			for c in ["Savaşçı","Büyücü","Rogue","Rahip","Paladin","Okçu"]:
				var b=GameButton.new()
				b.text=c
				b.pressed.connect(func(v=c): class_name_value=v)
				side_content.add_child(b)
		"Görünüm":
			var x=Label.new()
			x.text="Cinsiyet, saç, vücut ve ten seçeneklerini sağ panelden değiştirebilirsin."
			x.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART
			side_content.add_child(x)
		"İsim":
			var x=Label.new()
			x.text="Ortadaki isim alanı aktif."
			side_content.add_child(x)
		"Onay":
			var x=Label.new()
			x.text="Karakter: %s\nIrk: %s\nSınıf: %s\nCinsiyet: %s"%[name_input.text,race,class_name_value,"Erkek" if gender=="male" else "Kadın"]
			x.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART
			side_content.add_child(x)

func _next_tab() -> void:
	var tabs=["Irk","Sınıf","Görünüm","İsim","Onay"]
	var idx=tabs.find(selected_tab)
	_show_tab(tabs[min(idx+1,tabs.size()-1)])

func _refresh_preview() -> void:
	if not preview:
		return
	if gender=="male":
		preview.texture=MALE_SHORT if hair==0 else MALE_LONG
	else:
		preview.texture=FEMALE_LONG if hair==0 else FEMALE_BRAID
	preview.modulate=skin_tint
	preview.scale.x=body_scale
