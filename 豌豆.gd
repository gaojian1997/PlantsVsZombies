extends Node2D

func _process(delta):
  position.x += 225 * delta

func _on_bean_area_2d_area_entered(area):
  if area.is_in_group("zombie"):
    set_process(false)
    $AnimationPlayer.play("die")

func _on_visible_on_screen_notifier_2d_screen_exited():
  queue_free()

func _on_animation_player_animation_finished(anim_name):
  if anim_name == "die":
    queue_free()
