extends Area2D

var SPEED = 50

func _process(delta):
	position.x -= SPEED * delta

	if position.x < -50:  # off-screen
		queue_free()


func _on_body_entered(body):
	queue_free() 
	if body.has_method("get_energized"):
		body.get_energized()
