extends Control
class_name InventoryScreen

signal navigate(screen:String)

func _ready()->void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var root=VBoxContainer.new(); root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); root.offset_left=50; root.offset_top=40; root.offset_right=-50; root.offset_bottom=-40; root.add_theme_constant_override("separation",18); add_child(root)
	var top=HBoxContainer.new(); root.add_child(top)
	var back=GameButton.new(); back.text="‹ MENÜ"; back.custom_minimum_size=Vector2(160,56); back.pressed.connect(func():navigate.emit("menu")); top.add_child(back)
	var title=Label.new(); title.text="ENVANTER"; title.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; title.size_flags_horizontal=Control.SIZE_EXPAND_FILL; title.add_theme_font_size_override("font_size",42); top.add_child(title)
	var gold=Label.new(); gold.text="◉ 1.245"; gold.custom_minimum_size=Vector2(160,56); gold.horizontal_alignment=HORIZONTAL_ALIGNMENT_RIGHT; gold.add_theme_color_override("font_color",ThemeFactory.GOLD); top.add_child(gold)

	var body=HBoxContainer.new(); body.size_flags_vertical=Control.SIZE_EXPAND_FILL; body.add_theme_constant_override("separation",24); root.add_child(body)
	var equip=GamePanel.new(); equip.custom_minimum_size=Vector2(650,0); body.add_child(equip)
	var ev=VBoxContainer.new(); ev.alignment=BoxContainer.ALIGNMENT_CENTER; equip.add_child(ev)
	var avatar=Label.new(); avatar.text="♞"; avatar.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER; avatar.add_theme_font_size_override("font_size",210); avatar.add_theme_color_override("font_color",Color("#b78d58")); ev.add_child(avatar)
	var eqgrid=GridContainer.new(); eqgrid.columns=4; ev.add_child(eqgrid)
	for item in [["⚔","silah"],["⛨","zırh"],["◈","yüzük"],["⌁","kolye"],["⌂","miğfer"],["◇","bot"],["✦","tılsım"],["□","boş"]]:
		eqgrid.add_child(InventorySlot.new().setup(item[0],item[1],1))

	var bag=GamePanel.new(); bag.size_flags_horizontal=Control.SIZE_EXPAND_FILL; body.add_child(bag)
	var bv=VBoxContainer.new(); bv.add_theme_constant_override("separation",14); bag.add_child(bv)
	var tabs=HBoxContainer.new(); bv.add_child(tabs)
	for t in ["TÜMÜ","SİLAH","ZIRH","İKSİR","GÖREV"]:
		var b=GameButton.new(); b.text=t; b.custom_minimum_size=Vector2(135,54); tabs.add_child(b)
	var grid=GridContainer.new(); grid.columns=6; grid.size_flags_vertical=Control.SIZE_EXPAND_FILL; bv.add_child(grid)
	var items=[["⚔","ejderha_kilici"],["⛨","kara_kalkan"],["◉","altin_yuzuk"],["●","can_iksiri"],["◆","mana_iksiri"],["▣","runik_kitap"],["⌁","gizemli_muhur"],["✦","kristal"],["♜","eski_migfer"]]
	for i in range(24):
		if i<items.size(): grid.add_child(InventorySlot.new().setup(items[i][0],items[i][1],1))
		else:grid.add_child(InventorySlot.new().setup("","",0))
	var detail=PanelContainer.new(); detail.custom_minimum_size=Vector2(0,160); detail.add_theme_stylebox_override("panel",ThemeFactory.inset_box()); bv.add_child(detail)
	var d=Label.new(); d.text="EJDERHA KILICI\nNadir · Saldırı Gücü +12 · Kritik Şans %8\nEjderhaların öfkesini taşıyan kadim bir silah."; d.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART; d.add_theme_color_override("font_color",ThemeFactory.TEXT); detail.add_child(d)
