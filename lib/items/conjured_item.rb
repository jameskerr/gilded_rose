class ConjuredItem < NormalItem
  def update_quality
    data.sell_in -= 1
    data.quality -= 2
    data.quality = 0 if data.quality < 0
  end
end