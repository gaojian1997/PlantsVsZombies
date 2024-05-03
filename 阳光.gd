extends Node2D

var padding = 100
var padding_top = 150
var max_position_y
var is_from_sunflower = false

func collect_sun():
  var t = get_tree().create_tween()
  t.tween_property(self, "global_position", Vector2(80, 80), 0.5).set_ease(Tween.EASE_IN_OUT)
  t.connect("finished", queue_free_self)

func queue_free_self():
  Store.score += 25
  queue_free()

func _ready():
  $Timer.start(7.5)
  if is_from_sunflower:
    var t = get_tree().create_tween()
    t.tween_property(self, "global_position", self.global_position + Vector2(40, 40), 2)
    return
  var rng = RandomNumberGenerator.new()
  var screen_size = get_viewport_rect().size
  position.x = rng.randi_range(padding, screen_size.x - padding)
  position.y = -padding
  max_position_y = rng.randi_range(padding + padding_top, screen_size.y - padding)

func _process(delta):
  rotation_degrees += 50 * delta
  if is_from_sunflower:
    return
  if position.y < max_position_y:
    position.y += 175 * delta

func _on_texture_button_down():
  collect_sun()

func _on_timer_timeout():
  queue_free()
