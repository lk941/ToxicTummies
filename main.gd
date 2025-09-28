extends Control

@onready var score_label = $ScoreCount
@onready var finalscore_label = $FinalScoreCount
@onready var timer = $Timer

@onready var play_button = $GameState/StartButton
@onready var start_label = $GameState/GameStartLabel

var score = 0
var final_score
var game_started: bool = false
var game_end: bool = false

func _process(delta):
	#print("process1")
	#print("process2")
	pass
	
func _ready():
	pass

func game_start():
	score_label.text = str(score)	# display initial score
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	timer.start()	# remove(?)
	
	# Make obstacles, healthbar and score visble
	%ScoreCount.visible = true
	%ScoreLabel.visible = true
	%CurvedJellies.visible = true
	
	
func game_over():
	print("Game over node:", self, " score=", score)
	game_end = true
	Main.game_started = false
	#print(score)
	
	final_score = score
	print("final_score below")
	print(final_score)
	#finalscore_label.text = str(final_score)
	#%FinalScoreCount.visible = true
	#%FinalScoreLabel.visible = true
	
	get_tree().paused = true
	
	
# Game Over
#func temp_game_over_func():
	#%GameOverScreen.visible = true
	#get_tree().paused = true #pause the game
	#


func _on_timer_timeout():
	score += 1	# increment score
	score_label.text = str(score)	# update UI
	print("Timer node:", self, " score=", score)


func _on_start_button_pressed() -> void:
	Main.game_started = true
	start_label.visible = false
	play_button.visible = false
	
	game_start()
