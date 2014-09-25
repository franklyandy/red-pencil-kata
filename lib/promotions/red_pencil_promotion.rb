module Promotions
  class RedPencilPromotion

    MINIMUM_PRICE_REDUCTION = -5.00
    MAXIMUM_PRICE_REDUCTION = -30.00

    def initialize(price_change)
      @price_change = price_change
    end

    def is_allowed?
      @price_change.last_changed <= Date.today - 30 &&
      @price_change.percent_changed.between?(
        MAXIMUM_PRICE_REDUCTION,
        MINIMUM_PRICE_REDUCTION
      )
    end

  end
end
