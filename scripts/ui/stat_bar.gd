extends VBoxContainer
class_name StatBar

var label_node:Label
var bar:ProgressBar

func setup(label_text:String, value:float, max_value:float, tint:Color) -> StatBar:
	label_node = Label.new()
	label_node.text = label_text
	label_node.add_theme_font_size_override("font_size",18)
	bar = ProgressBar.new()
	bar.custom_minimum_size = Vector2(280, 26)
	bar.max_value = max_value
	bar.value = value
	bar.show_percentage = false
	var bg = ThemeFactory.box(Color("#090d10"), Color("#40372c"), 1, 5)
	var fill = ThemeFactory.box(tint, tint.lightened(0.15), 1, 5)
	bar.add_theme_stylebox_override("background", bg)
	bar.add_theme_stylebox_override("fill", fill)
	add_child(label_node)
	add_child(bar)
	return self

func set_value(v:float) -> void:
	if bar:
		bar.value = v
