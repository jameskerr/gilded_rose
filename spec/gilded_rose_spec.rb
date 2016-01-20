require_relative '../lib/gilded_rose'

describe "#update_quality" do

  context "with a single item" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:name) { "item" }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "decreases quality by 1" do
      expect(item.quality).to eq(9)
    end

    it "decreases sell_in by 1" do
      expect(item.sell_in).to eq(4)
    end

    context "sell by date has passed" do
      let(:initial_sell_in) { 0 }

      it "decreases quality by 2" do
        expect(item.quality).to eq(8)
      end

      it "decreases sell_in by 1" do
        expect(item.sell_in).to eq(-1)
      end
    end

    context "quality is 0" do
      let(:initial_quality) { 0 }

      it "does not change the quality" do
        expect(item.quality).to eq(0)
      end
    end

    context "Aged Brie" do
      let(:name) { "Aged Brie" }

      it "increases in quality by 1" do
        expect(item.quality).to eq(11)
      end

      context "quality is 50" do
        let(:initial_quality) { 50 }

        it "does not increment quality beyond 50" do
          expect(item.quality).to eq(50)
        end
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      let(:name) { "Sulfuras, Hand of Ragnaros" }
      let(:initial_quality) { 80 }

      it "never decreases the sell_in value" do
        expect(item.sell_in).to eq(5)
      end

      it "never decreases in quality" do
        expect(item.quality).to eq(80)
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do
      let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

      context "20 days left until concert" do
        let(:initial_sell_in) { 20 }

        it "increases in quality by 1" do
          expect(item.quality).to eq(11)
        end
      end

      context "10 days left until concert" do
        let(:initial_sell_in) { 10 }

        it "increases in quality by 2" do
          expect(item.quality).to eq(12)
        end
      end

      context "5 days left until concert" do
        let(:initial_sell_in) { 5 }

        it "increases in quality by 3" do
          expect(item.quality).to eq(13)
        end

        context "quality is 50" do
          let(:initial_quality) { 50 }

          it "does not increase quality above 50" do
            expect(item.quality).to eq(50)
          end
        end
      end

      context "0 days left until concert" do
        let(:initial_sell_in) { 0 } 

        it "drops quality to 0" do
          expect(item.quality).to eq(0)
        end
      end
    end

    context "Conjured" do
      let(:name) { "Conjured" } 

      it "decreases in quality by 2" do
        expect(item.quality).to eq(8)
      end

      context "quality is 0" do
        let (:initial_quality) { 0 }

        it "does not decrease quality below 0" do
          expect(item.quality).to eq(0)
        end
      end
    end
  end

  context "with multiple items" do
    let(:items) {
      [
        Item.new("NORMAL ITEM", 5, 10),
        Item.new("Aged Brie", 0, 49),
        Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 30),
        Item.new("Conjured", 1, 50)
      ]
    }

    let(:sell_ins)  { items.map(&:sell_in) }
    let(:qualities) { items.map(&:quality) }

    before { update_quality(items) }

    it "properly changes sell_ins" do
      expect(sell_ins).to eq([4, -1, 0, 3, 0])
    end

    it "properly changes qualities" do
      expect(qualities).to eq([9, 50, 80, 33, 48])
    end

  end
end
