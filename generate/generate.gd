extends Node
const SPAWN_X_RANGE = Vector2(1185, 1800)   # min and max X
const SPAWN_Y_RANGE = Vector2(475-120, 475)   # min and max Y

# How often to spawn
@export var spawn_interval := 2  # seconds
@export var arranged_interval := 10.0
@export var arranged_y_position := 465
var timer: Timer  # store a reference

const OBS_SCALE = 2.654

var to_spawn_array = [
	preload("res://obstacle/obstacle.tscn"),
	#preload("res://collectibles/curved_arrangement.tscn"),
	#preload("res://shield.tscn"),
	#preload("res://collectibles/red_jelly.tscn"),
	#preload("res://collectibles/green_jelly.tscn")
	]


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
	
	#timer_arranged = Timer.new()
	#timer_arranged.wait_time = arranged_interval
	#timer_arranged.one_shot = false
	#add_child(timer_arranged)
	#timer_arranged.timeout.connect(_spawn_arranged, CONNECT_DEFERRED)
	#timer_arranged.start()

func _on_timer_timeout():
	var scene = to_spawn_array.pick_random()
	var spawn_Obj = scene.instantiate()
	spawn_Obj.scale = Vector2(OBS_SCALE, OBS_SCALE)
		# Random X and Y within your ranges
	var x = randf_range(SPAWN_X_RANGE.x, SPAWN_X_RANGE.y)
	var y = randf_range(SPAWN_Y_RANGE.x, SPAWN_Y_RANGE.y)
		
	if scene.resource_path.get_file() == "curved_arrangement.tscn":
		y = 420
	elif scene.resource_path.get_file() == "shield.tscn":
		y -= 50
	#var obstacle = obstacle_scene.instantiate()
	
	spawn_Obj.position = Vector2(x, y)
	add_child(spawn_Obj)
