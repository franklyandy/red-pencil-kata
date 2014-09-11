require 'spec_helper'
require 'promotions/red_pencil_promotion'

include Promotions

describe RedPencilPromotion do

  Given(:promotion) { RedPencilPromotion.new }

  describe 'is_applied?' do

    Given(:price_change) {
      object_double 'PriceChange', {
        percent_changed: percent_changed
      }
    }
    When(:result) { promotion.is_applied? price_change }

    describe 'when the original price has been stable for at least 30 days' do

      examples = [
        { price_change_percent: -4.99,  promotion_is_applied?: false },
        { price_change_percent: -5.00,  promotion_is_applied?: true },
        { price_change_percent: -5.01,  promotion_is_applied?: true },
        { price_change_percent: -29.99, promotion_is_applied?: true },
        { price_change_percent: -30.00, promotion_is_applied?: true },
        { price_change_percent: -30.01, promotion_is_applied?: false },
      ]

      examples.each do |example|

        describe "and the price is changed by #{'%.02f' % example[:price_change_percent]}%" do
          Given(:percent_changed) { example[:price_change_percent] }

          describe "then the promotion should#{' not' unless example[:promotion_is_applied?]} be applied" do
            Then { result == example[:promotion_is_applied?] }
          end

        end
      end

    end

    describe 'when the original price has not beeen stable for at least 30 days' do
    end

  end

end
