extends Node2D

@onready var sun_scene = preload("res://阳光.tscn")

var hp = 50
var index

func underattack(damage):
  hp -= damage
  if hp <= 0:
    queue_free()
    Store.grass_cache[index] = 0

func _ready():
  $Timer.start(10)

func _on_timer_timeout():
  var sun = sun_scene.instantiate()
  sun.is_from_sunflower = true
  add_child(sun)
  sun.scale = Vector2(2, 2)
  sun.global_position = global_position
  
func _on_sun_flower_area_2d_entered(area):
  if area.is_in_group("zombie"):
    $Timer.stop()

func _on_sun_flower_area_2d_exited(area):
  if area.is_in_group("zombie"):
    $Timer.start()
