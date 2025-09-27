extends Area2D

var SPEED = 300

func _process(delta):
	position.x -= SPEED * delta

	if position.x < -50:  # off-screen
		queue_free()
