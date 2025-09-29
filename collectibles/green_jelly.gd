extends Area2D

var SPEED = 300

func _process(delta):
	if Main.game_started:
		position.x -= SPEED * delta

		#if position.x < -50:  # off-screen
			#queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free() 
	if body.has_method("get_energized"):
		body.get_energized()
