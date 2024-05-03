extends Node2D

var prev_score

func update_score_label(score):
  $Label.text = str(score)

func change_score_to(score):
  var t = create_tween()
  t.tween_method(update_score_label, prev_score, score, 0.25)

func _ready():
  prev_score = Store.score
  update_score_label(Store.score)

func _process(_delta):
  $Sprite2D.rotation_degrees += 1
  if prev_score != Store.score:
    change_score_to(Store.score)
    prev_score = Store.score
