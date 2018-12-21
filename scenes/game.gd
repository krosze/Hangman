extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var counter

signal game_over
signal win
signal reset

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	counter = 0

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_word_notthere():
	counter = counter + 1
	print(counter)
	match counter:
		1: $hangman/person/head.show()
		2: $hangman/person/torso.show()
		3: $hangman/person/right_arm.show()
		4: $hangman/person/left_arm.show()
		5: $hangman/person/right_leg.show()
		6: $hangman/person/left_leg.show()
	if counter == 6:
		emit_signal("game_over")


func _on_word_goodjob():
	emit_signal("win")


func _on_ui_start_over():
	emit_signal("reset")


func _on_game_reset():
	counter = 0
	for i in $hangman/person.get_children():
		i.visible = false
