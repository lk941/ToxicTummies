extends Area2D

func _process(delta):
	if Main.game_started:
		position.x -= GlobalConstants.SPEED * delta

		#if position.x < -50:  # off-screen
			#queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free() 
	if body.has_method("get_energized"):
		body.get_energized()
