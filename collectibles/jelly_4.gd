extends Area2D

var SPEED = 50

func _process(delta):
	position.x -= SPEED * delta

	if position.x < -50:  # off-screen
		queue_free()
