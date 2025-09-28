extends Area2D

var SPEED = 60

func _process(delta):
	if Main.game_started:
		position.x -= SPEED * delta

		#if position.x < -50:  # off-screen
			#queue_free()


#func _on_body_entered_shield(body: Node2D) -> void:
	#queue_free() 
	#if body.has_method("get_bagged"):
		#body.get_bagged()


func _on_body_entered(body):
	queue_free() 
	if body.has_method("get_bagged"):
		body.get_bagged()
