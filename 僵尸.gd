extends Node2D

var hp = 100
var plant = null

func _process(delta):
  if hp <= 0:
    return
  position.x -= 10 * delta

func _on_zombie_area_2d_entered(area):
  if hp <= 0:
    return
  if area.is_in_group("plant"):
    set_process(false)
    $AnimatedSprite2D.play("attack")
    plant = area.get_parent()
    $Timer.start(1)
  if area.is_in_group("bean"):
    hp -= 10
    if hp <= 0:
      # 碰撞层设置为空置层，防止错误碰撞
      $ZombieArea2D.collision_layer = 512
      $HeadAnimatedSprite2D.show()
      $HeadAnimatedSprite2D.play("default")
      $AnimatedSprite2D.play("die_walk")
  if area.name == "PepperArea2D":
    hp = 0
    $ZombieArea2D.collision_layer = 512
    $AnimatedSprite2D.play("die")
    set_process(false)

func _on_zombie_area_2d_exited(area):
  if hp <= 0:
    return
  if area.is_in_group("plant"):
    set_process(true)
    $AnimatedSprite2D.play("default")
    plant = null

func _on_animated_sprite_2d_finished():
  if ["die_laid", "die"].has($AnimatedSprite2D.animation):
    queue_free()

func _on_head_animated_sprite_2d_animation_finished():
  $AnimatedSprite2D.play("die_laid")
  set_process(false)
  
func _on_timer_timeout():
  if hp <= 0:
    return
  if plant:
    plant.underattack(10)
