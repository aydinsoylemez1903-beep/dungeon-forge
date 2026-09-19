extends Control

const SCREEN_CLASSES = {
	"menu": preload("res://scripts/screens/main_menu.gd"),
	"character": preload("res://scripts/screens/character_create.gd"),
	"inventory": preload("res://scripts/screens/inventory.gd"),
	"quests": preload("res://scripts/screens/quests.gd"),
	"hud": preload("res://scripts/screens/hud.gd"),
	"map": preload("res://scripts/screens/world_map.gd"),
	"combat": preload("res://scripts/screens/combat.gd"),
	"dialogue": preload("res://scripts/screens/dialogue.gd")
}

var current_screen:Control

func _ready()->void:
	theme=ThemeFactory.make_theme()
	_show("menu")

func _show(id:String)->void:
	if current_screen:
		current_screen.queue_free()
	var script=SCREEN_CLASSES.get(id,SCREEN_CLASSES["menu"])
	current_screen=Control.new()
	current_screen.set_script(script)
	add_child(current_screen)
	if current_screen.has_signal("navigate"):
		current_screen.navigate.connect(_show)
