extends Control

func _ready():
	if Main.game_end == false:
		hide()
	
func _process(_delta):
	if Main.game_end == true:
		show() # Same as self.visible = true
		
	else:
		hide()
