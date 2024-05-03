extends Node2D

@onready var sun_tscn = preload("res://阳光.tscn")
@onready var zombie_tscn = preload("res://僵尸.tscn")
@onready var coming = preload("res://assets/UI/一大波僵尸正在接近.png")
@onready var failed = preload("res://assets/UI/ZombiesWon.png")
var zombie_extra_hp = 0

func add_zombie():
  var zombie = zombie_tscn.instantiate()
  $"僵尸类".add_child(zombie)
  zombie.hp += zombie_extra_hp
  zombie_extra_hp += 20
  zombie.global_position.x = 1000
  zombie.global_position.y = [150, 270, 400, 510, 620].pick_random()

func _ready():
  $SunTimer.start(7.5)

func _on_timer_timeout():
  if $ZombieTimer.is_stopped():
    $TipSprite2D.texture = coming
    $TipSprite2D.position = Vector2(360, 320)
    $TipSprite2D.show()
    $TipTimer.start(2)
    $ZombieTimer.start(10)
  var sun = sun_tscn.instantiate()
  $"阳光类".add_child(sun)

func _on_zombie_timer_timeout():
  add_zombie()

func _on_tip_timer_timeout():
  $TipSprite2D.hide()

func _on_death_area_2d_entered(area):
  if area.is_in_group("zombie"):
    $TipSprite2D.texture = failed
    $TipSprite2D.position = Vector2(290, 230)
    $TipSprite2D.show()
    get_tree().paused = true

func _on_bgm_finished():
  $BGM.play()
