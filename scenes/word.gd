extends Node2D

export (String) var input
var line = preload("res://scenes/space.tscn")

var arr_labels = []
var alpha = []
var words = ["i am happy", "devilman", "bubble tea", "noodles", "danganronpa", "apple pie", "zetsubou", "godot", "ice cream", "lostboycrow"]

var length
var temp

signal notthere
signal goodjob

func _ready():
	randomize()
		
	#temp = str(input)
	temp = words[randi() % words.size()]
	alpha.clear()
	arr_labels.clear()
	
	temp = temp.replace(" ", "/")
	
	initialize()
		
	temp = temp.replace("/", "")
	length = temp.length()
	

func initialize():
	var pos = $start.position
	var counter = 0
	
	for i in temp:
		var space = line.instance()
		space.position = pos
		space.translate(Vector2(70 * counter, 0))
		var lab = space.get_node("text")
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


func _on_game_reset():
	for i in range(arr_labels.size()):
		arr_labels[i].text = ""
	_ready()
