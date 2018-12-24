extends Node2D

export (String) var input
var line = preload("res://scenes/space.tscn")

var arr_labels = []
var alpha = []
var arr_spaces = []
var words = ["mango", "code", "bubble tea", "noodles", "kamimashita", "apple pie", "candy", "godot", "ice cream", "apple pie"]

var length
var temp

signal notthere
signal goodjob
signal mayoi

func _ready():
	randomize()
		
	#temp = str(input)
	input = words[randi() % words.size()]
	temp = input
	arr_labels.clear()
	alpha.clear()
	arr_spaces.clear()
	
	temp = temp.replace(" ", "/")
	
	initialize()
		
	temp = temp.replace("/", "")
	length = temp.length()
	

func initialize():
	var pos = $start.position
	var counter = 0
	
	for i in temp:
		var space = line.instance()
		arr_spaces.append(space)
		space.position = pos
		space.translate(Vector2(70 * counter, 0))
		var lab = space.get_node("letter")
		if i != "/":
			arr_labels.append(lab)
		elif i == "/":
			var temp_line = space.get_node("line")
			temp_line.hide()
			
		add_child(space)
		counter = counter + 1		


func not_there():
	emit_signal("notthere")
	
	
func handle_string(s):
	var pos = temp.find(s)
	
	$click.play()

	if pos != -1:
		for i in range(pos, length):
			if temp.substr(i, 1) == s:
				arr_labels[i].text = s
		temp = temp.replace(s, "/")		
		alpha.append(s)
	elif alpha.find(s) != -1:
		pass
	else:
		emit_signal("notthere")

	win()
	
	
func win():
	var slash_counter = 0
	for i in temp:
		if i == "/":
			slash_counter = slash_counter + 1	
	if slash_counter == length:
		emit_signal("goodjob")
		if input == "kamimashita":
			emit_signal("mayoi")


func _on_game_reset():
	for i in range(arr_spaces.size()):
		arr_spaces[i].get_node("letter").queue_free()
		arr_spaces[i].get_node("line").queue_free()
	_ready()
