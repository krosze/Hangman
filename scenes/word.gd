extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (String) var input
var line = preload("res://scenes/space.tscn")
var arr_labels = []
var alpha = []
var length
var temp
var counter

signal notthere
signal goodjob

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var pos = $start.position
	length = input.length()
	temp = str(input)
	alpha.clear()
	arr_labels.clear()
	
	for i in input:
		alpha.append(i)
	
	counter = 0
	
	for i in range(length):
		var space = line.instance()
		space.position = pos
		space.translate(Vector2(70 * i, 0))
		var lab = space.get_node("text")
		arr_labels.append(lab)
		add_child(space)

func not_there():
	emit_signal("notthere")
	
func handle_string(s):
	var slash_counter = 0
	var char_not_there = 0
	
	for i in range(length):
		if temp.substr(i, 1) == s:
			for i in range(length):
				if temp.substr(i, 1) == s:
					arr_labels[i].text = s
			counter = counter + 1
			temp = temp.replace(s, "/")
			alpha.append(s)
		elif alpha.find(s) != -1:
			pass
		else:
			char_not_there = char_not_there + 1
			if char_not_there == length:
				emit_signal("notthere")

	for i in temp:
		if i == "/":
			slash_counter = slash_counter + 1	
	if slash_counter == length:
		emit_signal("goodjob")

func _on_game_reset():
	for i in range(arr_labels.size()):
		arr_labels[i].text = ""
	_ready()
