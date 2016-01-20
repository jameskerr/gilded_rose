class NormalItem
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def update_quality
    data.sell_in -= 1

    if data.sell_in < 0
      data.quality -= 2
    else 
      data.quality -= 1
    end
    
    data.quality = 0 if data.quality < 0 
  end
end