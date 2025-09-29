extends Node2D

signal hunger_depleted

var velocity: Vector2 = Vector2.ZERO

var toxic_level = 30
var hunger_level = 80
var jump_strength = -300.0
var on_ground = 1

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle")
	#var viewport_size = get_viewport_rect().size
	#position = viewport_size * Vector2(0.5, 0.5)   
	
	
func _physics_process(delta: float):
	
	# health bar progresses after game start
	if Main.game_started:
		%ToxicBar.visible = true
		%HungerBar.visible = true
		if !Global.shielded:
			toxic_level += 0.01
		hunger_level -= 0.01
		%HungerBar.value = hunger_level
		%ToxicBar.value = toxic_level
		print(%ToxicBar.value)
		
		if %ToxicBar.value >= 100 or %HungerBar.value <= 0:
			%GameOverScreen.visible = true
			get_parent().game_over()
			
			
			
	
	# keeps player on ground
	if velocity.y > 0:	
		velocity.y = 0
	
	# Jump when pressed spacebar
	
	if Input.is_action_just_pressed("jump"):
		if on_ground == 1:
			on_ground = 0
			velocity.y = jump_strength
			jump()
			
	if Input.is_action_just_pressed("slide"):
		if on_ground == 1:
			on_ground = 0
			slide()
	
	#if hunger_level <= 0.0:
		#hunger_depleted.emit()
					  
					
func jump():
	anim.play("jump")  
	var up_by = 120
	var up_time = 0.5
	var down_time = 0.5
	var t = create_tween()	# for smooth jump 
	t.tween_property(self, "position:y", position.y - up_by, up_time).set_trans(Tween.TRANS_SINE)
	t.tween_property(self, "position:y", position.y, down_time).set_trans(Tween.TRANS_SINE)
	t.tween_callback(set_on_ground_true) # Call a function after the final tween completes
	
func slide():
	anim.play("slide")
	var slide_distance = 0
	var slide_time = 0.5 
	
	if $CollisionShape2D:
		$CollisionShape2D.scale.y = 0.5
		
	var t = create_tween()
	t.tween_property(self, "position:x", position.x + slide_distance, slide_time).set_trans(Tween.TRANS_SINE)
	t.tween_callback(self._reset_collision_shape)  # Call function after slide
	t.tween_callback(set_on_ground_true)

func _reset_collision_shape():
	if $CollisionShape2D:
		$CollisionShape2D.scale.y = 1.0
		
func set_on_ground_true():
	on_ground = 1

func get_poisoned():
	toxic_level += 20
	%ToxicBar.value += 20
	anim.play("poisoned")
	print("Toxic bar changes below")    
	print(%ToxicBar.value)
func get_bagged():
	anim.play("bagged") 
	print("bagged!!")   
	
func get_energized():
	hunger_level += 10
	%HungerBar.value += 10
	print(%HungerBar.value)
	
	anim.play("idle")   # changed from bagged to idle 


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "jump":
		$AnimatedSprite2D.play("idle")	# returns to "idle" animation after jumping
			
