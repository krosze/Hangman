extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var start

signal start_over

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	start = true
	$restart/play_button.hide()
	$game/word.hide()
	_on_game_start()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_interactive_game_over():
	$game/alphabet.hide()
	$label.text = "game over"
	$anim.play("text_anim")
	$end_timer.start()


func _on_game_start():
	if start == true:
		$restart/play_button.disabled = true
		$game/alphabet.hide()
		$label.text = "hangman"
		$start_timer.start()
		$anim.play("text_anim")
		start = false


func _on_start_timer_timeout():
	$label.percent_visible = 0
	$game/word.show()
	$game/alphabet.show()


func _on_end_timer_timeout():
	$label.percent_visible = 0
	$restart/play_button.show()
	$restart/play_button.disabled = false
	$label.text = "play again?"
	$anim.play("text_anim")


func _on_game_win():
	$game/alphabet.hide()
	$label.text = "you win!"
	$anim.play("text_anim")
	$end_timer.start()


func _on_play_button_down():
	start = true
	emit_signal("start_over")
	_ready()
