class ChangeError < StandardError; end

class ChangeMaker
  class << self
    def make_change(amount, denominations = [1,5,10,25], coin_array = [])
      return coin_array if amount == 0
      raise ChangeError if denominations.size == 0
      denominations.reject! { |denomination| denomination > amount }

      optimal_coin_array = get_optimal_coin(amount, denominations)
      optimal_coin = optimal_coin_array.first
      optimal_coin_array.last.times { coin_array << optimal_coin }
      denominations.delete(optimal_coin)

      make_change(calculated_new_amount(amount, optimal_coin_array), denominations, coin_array)
    end

    def calculated_new_amount(amount, coin_array)
      amount - coin_array.first * coin_array.last
    end

    def get_optimal_coin(amount, denominations)
      denomination_divisor_hash = {}

      denominations.each do |denomination|
        denomination_divisor_hash[denomination] = amount / denomination
      end

      denomination_divisor_hash.sort_by { |_key, value| value }.first
    end
  end
end
