require 'spec_helper'
require 'promotions/red_pencil_promotion'

include Promotions

describe RedPencilPromotion do

  Given(:promotion) { RedPencilPromotion.new }

  describe 'is_applied?' do

    When(:result) { promotion.is_applied? }

    describe 'when the original price has been stable for at least 30 days' do

      describe 'and the price has been reduced by at least 5% but not more than 30%' do
        Then { result == true }
      end

      describe 'and the price has been reduced by less than 5%' do
      end

      describe 'and the price has been reduced by more than 30%' do
      end

    end

    describe 'when the original price has not beeen stable for at least 30 days' do
    end

  end

end
