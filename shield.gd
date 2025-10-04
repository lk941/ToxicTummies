extends Area2D

var timer: Timer  # store a reference
const SHIELD_DURATION = 5

func _process(delta):
	if Main.game_started:
		position.x -= GlobalConstants.SPEED * delta
		#if position.x < -50:  # off-screen
			#queue_free()




func _on_body_entered(body):
	Global.shielded = true
	print("Bagged")

	if body.has_method("get_bagged"):
		body.get_bagged()
	hide()
	# Wait for SHIELD_DURATION seconds
	await get_tree().create_timer(SHIELD_DURATION).timeout

	Global.shielded = false
	print("Shield ran out")

	
