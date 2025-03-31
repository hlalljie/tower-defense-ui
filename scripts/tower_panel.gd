extends Panel

@onready var tower = preload("res://scenes/tower.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Will check input if on top of the panel
func _on_gui_input(event: InputEvent) -> void:
	var tempTower = tower.instantiate()
	#print(event) # show the event
	if event is InputEventMouseButton and event.button_mask == 1:
		# left click down
		#print("Left button down")
		add_child(tempTower)
		tempTower.global_position = event.global_position # follow mouse
		
		tempTower.scale = Vector2(1.06, 1.06)
	elif event is InputEventMouseMotion and event.button_mask == 1:
		# Left click down and drag
		#print("Left button drag")
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position # follow mouse
	elif event is InputEventMouseButton and event.button_mask == 0:
		# Left button up
		print("Left button up")
		if get_child_count() > 1:
			get_child(1).queue_free() # delete ui tower
		
		# create tower in the main game Towers node
		var path = get_tree().get_root().get_node("Game/Towers")
		path.add_child(tempTower)
		
		var camera = get_tree().get_root().get_node("Game/PlayerCamera") # get camera for movement adjsutment
		tempTower.global_position = camera.get_global_mouse_position()
		
		tempTower.get_node("Area").hide()
	# Hotfix for right click more than one tower bug
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
	
	
