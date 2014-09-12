require 'promotions/red_pencil_promotion'
require 'timecop'

describe Promotions::RedPencilPromotion do

  examples = [
    { price_change_percent: -4.99,  promotion_is_applied?: false },
    { price_change_percent: -5.00,  promotion_is_applied?: true },
    { price_change_percent: -5.01,  promotion_is_applied?: true },
    { price_change_percent: -29.99, promotion_is_applied?: true },
    { price_change_percent: -30.00, promotion_is_applied?: true },
    { price_change_percent: -30.01, promotion_is_applied?: false },
  ]

  Given(:promotion) { Promotions::RedPencilPromotion.new price_change }

  describe 'is_applied?' do
    Given { Timecop.freeze(Time.new(2014, 1, 1, 7, 0, 0)) }
    Given(:price_change) {
      object_double 'PriceChange', {
        percent_changed: percent_changed,
        last_changed: last_changed,
      }
    }
    When(:result) { promotion.is_applied? }

    describe 'when the original price has been stable for at least 30 days' do
      Given(:last_changed) { Date.today - 30 }

      examples.each do |example|

        describe "and the price is changed by #{'%.02f' % example[:price_change_percent]}%" do
          Given(:percent_changed) { example[:price_change_percent] }

          describe "then the promotion should#{' not' unless example[:promotion_is_applied?]} be applied" do
            Then { result == example[:promotion_is_applied?] }
          end

        end
      end

    end

    describe 'when the original price has not been stable for at least 30 days' do
      Given(:percent_changed) {
        examples.find { |example|
          example[:promotion_is_applied?] == true
        }[:price_change_percent]
      }
      Given(:last_changed) { Date.today - 29 }
      Then { result == false }
    end

  end

end
