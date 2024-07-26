extends Node

var item : Equippable_item = null

var apple_status: String = ""


var chef_first_interaction: bool = false
#for efficiency (conditional fetching)
var has_moral_been_updated: bool = false

# for tut scene

signal dandelion_status_changed(new_status: bool)

# Declare the variable as a property with a setter and a getter
@export var has_dandelion: bool = false:
	set(value):
		if has_dandelion != value:
			has_dandelion = value
			emit_signal("dandelion_status_changed", has_dandelion)
	get:
		return has_dandelion
		
var burned_dandelion = false
var owlen_first_interaction = true
var owlen_first_interaction_after_give = true
var owlen_first_interaction_after_burn = true

		

var lightOn: bool = true
var cappySleeping_global: bool = false

var MORAL_SCORE : int = 0

func _ready():
	connect("dandelion_status_changed", Callable(self, "_on_dandelion_status_changed"))

	
func _on_dandelion_status_changed(new_status: bool):
	print("Dandelion status changed to: ", new_status)
	if new_status:
		# Find and delete the dandelion node
		var dandelion_node = get_node("/root/Tutorial_level/dandelion")
		if dandelion_node:
			dandelion_node.queue_free()
		else:
			#Okay this is just for tut level but dropping item is placing item in root not in tut level.
			dandelion_node = get_node("/root/dandelion")
			if dandelion_node:
				dandelion_node.queue_free()
	

func set_item(resource_path):
	# Load the resource
	var item = load(resource_path) as Equippable_item

	# Check if the item is loaded properly
	if item:
		print("Item loaded: ", item.display_name)
		
		if Cappy:
			# Access the HandEquip node within the player character
			var hand_equip = Cappy.find_child("HandEquip")
			if hand_equip:
				# Set the new item
				hand_equip.texture = item.texture
				hand_equip.set_equipped_item(item)
				
			else:
				print("Failed to find HandEquip node")
		else:
			print("Failed to find player character in Global")
	else:
		print("Failed to load item")

func set_moral_score(new_score):
	MORAL_SCORE = new_score
	has_moral_been_updated = true

