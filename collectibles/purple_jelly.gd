extends Area2D


func _process(delta):
	if Main.game_started:
		position.x -= GlobalConstants.SPEED * delta



func _on_body_entered(body: Node2D) -> void:
	queue_free() 
	if body.has_method("get_poisoned"):
		body.get_poisoned()
