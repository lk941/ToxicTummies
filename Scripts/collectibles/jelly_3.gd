extends Area2D


func _process(delta):
	position.x -= GlobalConstants.SPEED * delta

	if position.x < -50:  # off-screen
		queue_free()
