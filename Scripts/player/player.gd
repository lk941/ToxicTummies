extends Node2D

var velocity: Vector2 = Vector2.ZERO

var toxic_level = 30
var hunger_level = 80
var jump_strength = -300.0
var on_ground = 1

const TOXIC_DMG_VALUE = 10
const ENERGY_BUFF_VALUE = 2
const TOXIC_DMG_GRADUAL = 0.01
const ENERGY_DMG_GRADUAL = 0.01


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
			toxic_level += TOXIC_DMG_GRADUAL
		hunger_level -= ENERGY_DMG_GRADUAL
		%HungerBar.value = hunger_level
		%ToxicBar.value = toxic_level
		
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
	if !Global.shielded:
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
	var slide_time = 0.8
	var collision_y;
	var collision_scale;
	var collision_delay = 0.5  # adjust this value based on animation timing
	await get_tree().create_timer(collision_delay).timeout
	if $CollisionShape2D:
		collision_y = $CollisionShape2D.position.y 
		collision_scale = $CollisionShape2D.scale.y 
		$CollisionShape2D.scale.y = 0.5
		$CollisionShape2D.position.y += 35
	
	var t = create_tween()
	t.tween_property(self, "position:x", position.x + slide_distance, slide_time).set_trans(Tween.TRANS_SINE)
	await t.finished   # wait until tween completes

	

	_reset_collision_shape(collision_y, collision_scale)
	set_on_ground_true()

func _reset_collision_shape(collision_y, collision_scale):
	if $CollisionShape2D:
		$CollisionShape2D.scale.y = collision_scale
		$CollisionShape2D.position.y = collision_y

		
func set_on_ground_true():
	on_ground = 1

func get_poisoned():
	if !Global.shielded:
		toxic_level += TOXIC_DMG_VALUE
		%ToxicBar.value += TOXIC_DMG_VALUE
		anim.play("poisoned")
		$Burp8.play()
func get_bagged():
	anim.play("bagged") 
	
func get_energized():
	var value = min(hunger_level + ENERGY_BUFF_VALUE, 100)
	hunger_level = value
	%HungerBar.value = value
	$SfxEatgoodjelly.play()
	


func _on_animated_sprite_2d_animation_finished() -> void:
	
	
	if anim.animation == "jump" || anim.animation == "slide":
		if Global.shielded:
			anim.play("bagged")	# returns to "idle" animation after jumping
		else:	
			anim.play("idle")	# returns to "idle" animation after jumping
		
