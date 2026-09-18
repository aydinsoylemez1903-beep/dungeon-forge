extends RefCounted
class_name ThemeFactory

const BG = Color("#090d0f")
const PANEL = Color("#11191d")
const PANEL_2 = Color("#172228")
const GOLD = Color("#d39b45")
const GOLD_BRIGHT = Color("#f0be62")
const GOLD_DARK = Color("#6e4b24")
const TEXT = Color("#f2e7cf")
const MUTED = Color("#9d9b8f")
const RED = Color("#a3332d")
const BLUE = Color("#286b9f")
const PURPLE = Color("#69489e")
const GREEN = Color("#34714b")

static func box(fill:Color, border:Color = GOLD_DARK, width:int = 2, radius:int = 8) -> StyleBoxFlat:
	var s = StyleBoxFlat.new()
	s.bg_color = fill
	s.border_color = border
	s.set_border_width_all(width)
	s.set_corner_radius_all(radius)
	s.shadow_color = Color(0,0,0,0.55)
	s.shadow_size = 8
	return s

static func panel_box() -> StyleBoxFlat:
	return box(Color("#10171b"), Color("#7e5a2d"), 2, 10)

static func inset_box() -> StyleBoxFlat:
	return box(Color("#0b1114"), Color("#3f3428"), 1, 6)

static func button_box(state:String="normal") -> StyleBoxFlat:
	match state:
		"hover":
			return box(Color("#2c2117"), GOLD_BRIGHT, 2, 7)
		"pressed":
			return box(Color("#3c2b19"), GOLD, 2, 7)
		"disabled":
			return box(Color("#171717"), Color("#3a3a3a"), 1, 7)
		"active":
			return box(Color("#22344a"), Color("#61a8df"), 2, 7)
		_:
			return box(Color("#181c1c"), Color("#815d2c"), 2, 7)

static func make_theme() -> Theme:
	var t = Theme.new()
	t.set_color("font_color","Label",TEXT)
	t.set_color("font_color","Button",TEXT)
	t.set_color("font_hover_color","Button",Color.WHITE)
	t.set_color("font_pressed_color","Button",GOLD_BRIGHT)
	t.set_color("font_disabled_color","Button",Color("#5b5b5b"))
	t.set_font_size("font_size","Label",24)
	t.set_font_size("font_size","Button",22)
	t.set_stylebox("normal","Button",button_box())
	t.set_stylebox("hover","Button",button_box("hover"))
	t.set_stylebox("pressed","Button",button_box("pressed"))
	t.set_stylebox("disabled","Button",button_box("disabled"))
	t.set_stylebox("panel","PanelContainer",panel_box())
	t.set_stylebox("normal","LineEdit",inset_box())
	t.set_stylebox("normal","OptionButton",button_box())
	t.set_color("font_color","LineEdit",TEXT)
	t.set_color("font_placeholder_color","LineEdit",MUTED)
	return t
