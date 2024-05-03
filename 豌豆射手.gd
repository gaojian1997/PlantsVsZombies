extends Node2D

@onready var bean_tscn = preload("res://豌豆.tscn")
var hp = 100
var index

func underattack(damage):
  hp -= damage
  if hp <= 0:
    queue_free()
    Store.grass_cache[index] = 0

func _ready():
  $Timer.start(3)

func _process(delta):
  pass

func _on_timer_timeout():
  var bean = bean_tscn.instantiate()
  add_child(bean)
  bean.global_position = $Marker2D.global_position

func _on_bean_area_2d_entered(area):
  if area.is_in_group("zombie"):
    $Timer.stop()
    
func _on_bean_area_2d_exited(area):
  if area.is_in_group("zombie"):
    $Timer.start(3)
