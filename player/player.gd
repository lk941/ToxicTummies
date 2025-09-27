extends Node2D

signal hunger_depleted

var toxic_level = 30
var hunger_level = 80

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle")  
	
func _physics_process(delta):
	toxic_level += 0.1
	hunger_level -= 0.1
	%HungerBar.value = hunger_level
	%ToxicBar.value = toxic_level
	
	#if hunger_level <= 0.0:
		#hunger_depleted.emit()
					  

func get_poisoned():
	%ToxicBar.value += 20
	anim.play("poisoned")    
	print(toxic_level)
	
func get_bagged():
	anim.play("bagged")    
	
func get_energized():
	%HungerBar.value += 10
	print("energized + 10")
	anim.play("bagged")    
