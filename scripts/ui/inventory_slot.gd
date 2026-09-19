extends Button
class_name InventorySlot

var item_id := ""
var quantity := 0

func setup(symbol:String, id:String="", qty:int=0) -> InventorySlot:
	item_id = id
	quantity = qty
	text = symbol
	custom_minimum_size = Vector2(86,86)
	add_theme_font_size_override("font_size",34)
	tooltip_text = id.capitalize() if id != "" else "Boş slot"
	return self
