extends Node2D

func _ready():
	var anim = $AnimatedSprite2D
	anim.animation = "default"
	anim.play()                    
