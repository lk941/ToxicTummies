extends Node
const SPAWN_X_RANGE = Vector2(1185, 1200)   # min and max X
const SPAWN_Y_RANGE = Vector2(465-120, 465)   # min and max Y

# How often to spawn
@export var spawn_interval := 2.0  # seconds
var timer: Timer  # store a reference
var obstacle_scene = preload("res://obstacle/obstacle.tscn")

func start_spawning():
	# Create a Timer node
	timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.autostart = false
	timer.one_shot = false  # repeat
	add_child(timer)         # add it to the scene tree
	
	# Connect the timeout signal
	timer.timeout.connect(_on_timer_timeout, CONNECT_DEFERRED)
	
	# Start the timer
	timer.start()

func _on_timer_timeout():
	var obstacle = obstacle_scene.instantiate()
	# Random X and Y within your ranges
	var x = randf_range(SPAWN_X_RANGE.x, SPAWN_X_RANGE.y)
	var y = randf_range(SPAWN_Y_RANGE.x, SPAWN_Y_RANGE.y)
	obstacle.position = Vector2(x, y)
	add_child(obstacle)
