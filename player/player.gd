extends Node2D

signal hunger_depleted

var velocity: Vector2 = Vector2.ZERO

var toxic_level = 30
var hunger_level = 80
var jump_strength = -300.0

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle")                       
	
func _physics_process(delta: float):
	toxic_level += 0.1
	hunger_level -= 0.1
	%HungerBar.value = hunger_level
	%ToxicBar.value = toxic_level
	if velocity.y > 0:
		velocity.y = 0
	
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_strength
		jump()
	
	#if hunger_level <= 0.0:
		#hunger_depleted.emit()
					  
					
func jump():
	anim.play("jump")  
	var up_by = 120
	var up_time = 0.5
	var down_time = 0.5
	var t = create_tween()
	t.tween_property(self, "position:y", position.y - up_by, up_time).set_trans(Tween.TRANS_SINE)
	t.tween_property(self, "position:y", position.y, down_time).set_trans(Tween.TRANS_SINE)

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


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "jump":
		$AnimatedSprite2D.play("idle")
