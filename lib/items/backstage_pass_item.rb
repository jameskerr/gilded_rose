class BackstagePassItem < NormalItem
  def update_quality
    data.sell_in -= 1

    if data.sell_in < 0
      data.quality = 0
    elsif data.sell_in <= 5
      data.quality += 3
    elsif data.sell_in <= 10
      data.quality += 2
    else
      data.quality += 1
    end
    
    data.quality = 50 if data.quality > 50
  end
end