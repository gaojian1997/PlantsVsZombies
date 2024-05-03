extends Node2D

var index

func _ready():
  $Timer.start(2)

func _on_timer_timeout():
  # 激活火爆辣椒碰撞层
  $PepperArea2D.collision_layer = 3
  $AnimatedSprite2D.play("boom")

func _on_animated_sprite_2d_animation_finished():
  if $AnimatedSprite2D.animation == 'boom':
    queue_free()
    Store.grass_cache[index] = 0
