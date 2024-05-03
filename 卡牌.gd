extends TextureButton

@export var card_resource:CardResource
@onready var bean = preload("res://豌豆射手.tscn")

func _get_drag_data(_at_position):
  if Store.score < card_resource.pic_score_cost:
    return
  var rect_card = TextureRect.new()
  rect_card.scale = Vector2(0.5, 0.5)
  rect_card.texture = card_resource.drag_pic
  rect_card.pivot_offset = -rect_card.get_minimum_size() / 2
  set_drag_preview(rect_card)
  Store.drag_pic.id = card_resource.pic_id
  Store.drag_pic.cost = card_resource.pic_score_cost
  return rect_card

func _ready():
  texture_normal = card_resource.pic

func _process(_delta):
  if Store.score < card_resource.pic_score_cost:
    modulate = Color8(100, 100, 100, 255)
  else:
    modulate = Color8(225, 255, 255, 255)
