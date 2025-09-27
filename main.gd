extends Control

@onready var score_label = $ScoreCount
@onready var timer = $Timer

@onready var play_button = $GameState/StartButton
@onready var start_label = $GameState/GameStartLabel

var score = 0

func _ready():
	pass


func game_start():
	score_label.text = str(score)
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

# Game Over
#func temp_game_over_func():
	#%GameOverScreen.visible = true
	#get_tree().paused = true #pause the game
	#


func _on_timer_timeout():
	score += 1
	score_label.text = str(score)


func _on_start_button_pressed() -> void:
	start_label.visible = false
	play_button.visible = false
	
	game_start()
