extends Area2D

const SCALE = 2.654 #@TODO not use this if improving code
const SPEED = 300 * SCALE

func _process(delta):
	global_position.x -= SPEED * delta

	if global_position.x < -50:  # off-screen
		queue_free()


func _on_body_entered(body):
	queue_free() 
	if body.has_method("get_poisoned"):
		body.get_poisoned()
