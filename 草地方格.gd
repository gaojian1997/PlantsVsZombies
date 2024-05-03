extends TextureRect

@onready var sunflower = preload("res://向日葵.tscn")
@onready var bean_shooter = preload("res://豌豆射手.tscn")
@onready var pepper = preload("res://火爆辣椒.tscn")
@export var id:int

func get_plant():
  match Store.drag_pic.id:
    1:
      return sunflower
    2:
      return bean_shooter
    3:
      return pepper

func _can_drop_data(at_position, data):
  if Store.grass_cache[id] != 0:
    return false
  return true
  
func _drop_data(at_position, data):
  var plant = get_plant().instantiate()
  add_child(plant)
  plant.index = id
  plant.global_position = $Marker2D.global_position
  Store.grass_cache[id] = Store.drag_pic.id
  Store.score -= Store.drag_pic.cost
