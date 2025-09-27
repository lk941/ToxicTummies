extends Node2D

var level_of_toxicity = 30

@onready var anim = $AnimatedSprite2D

func _ready():
	#print(level_of_toxicity)
	#anim.animation = "idle"
	anim.play("idle")  
					  

func get_poisoned():
	%ToxicBar.value += 20
	#level_of_toxicity += 20
	anim.play("poisoned")    
	print(level_of_toxicity)
	
func get_bagged():
	anim.play("bagged")    
	print("hi")
