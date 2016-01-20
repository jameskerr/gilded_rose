require_relative 'items/normal_item.rb'
require_relative 'items/aged_brie_item.rb'
require_relative 'items/backstage_pass_item.rb'
require_relative 'items/sulfuras_item.rb'

ITEMS = Hash.new(NormalItem).merge({
  "Aged Brie"                                 => AgedBrieItem,
  "Sulfuras, Hand of Ragnaros"                => SulfurasItem,
  "Backstage passes to a TAFKAL80ETC concert" => BackstagePassItem
})

def update_quality(items)
  items.each do|item|
    ITEMS[item.name].new(item).update_quality
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
