class AgedBrieItem < NormalItem
  def update_quality
    data.sell_in -= 1
    data.quality += 1
    data.quality = 50 if data.quality > 50
  end
end