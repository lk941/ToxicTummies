extends ColorRect

var speed = 300

func _process(delta):
	position.x -= speed * delta

	if position.x < -50:  # off-screen
		queue_free()
