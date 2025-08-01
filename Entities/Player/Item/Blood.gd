extends Item

func _process(_delta: float) -> void:
    if stock == 0: $TextureRect.texture.region = Rect2(0, 0, 15, 15)
    else: $TextureRect.texture.region = Rect2(15, 0, 15, 15)
    $Label.text = str(stock)
