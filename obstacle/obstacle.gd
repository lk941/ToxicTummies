extends Area2D

const SCALE = 2.654 #@TODO not use this if improving code


func _process(delta):
	position.x -= GlobalConstants.SPEED * SCALE * delta
	if position.x < -50:  # off-screen
		queue_free()


func _on_body_entered(body):
	queue_free() 
	if body.has_method("get_poisoned"):
		body.get_poisoned()
