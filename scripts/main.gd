extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var start
var play_sound

signal start_over

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	start = true
	play_sound = true
	$play_button.hide()
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
		$play_button.disabled = true
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
	$play_button.disabled = false
	$play_button.show()

func _on_game_win():
	$game/alphabet.hide()
	$label.text = "you win!"
	$anim.play("text_anim")
	$end_timer.start()


func _on_play_button_down():
	start = true
	play_sound = true
	emit_signal("start_over")
	_ready()


func _on_anim_animation_finished(anim_name):
	if play_sound:
		$start_sound.play()
		play_sound = false


func _on_word_mayoi():
	$mayoi.visible = true
	$mayoi/mayoi_timer.start()


func _on_mayoi_timer_timeout():
	$mayoi.visible = false
