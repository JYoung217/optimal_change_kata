class ChangeError < StandardError; end

class ChangeMaker
  class << self
    def make_change(amount, denominations = [1,5,10,25], coin_array = [])
      return coin_array if amount == 0
      raise ChangeError if denominations.size == 0
      denominations.reject! { |denomination| denomination > amount }

      greedy_coin_array = get_greedy_coin(amount, denominations)
      optimal_coin = greedy_coin_array.first
      greedy_coin_array.last.times { coin_array << optimal_coin }
      denominations.delete(optimal_coin)

      make_change(calculated_new_amount(amount, greedy_coin_array), denominations, coin_array)
    end

    def calculated_new_amount(amount, coin_array)
      amount - coin_array.first * coin_array.last
    end

    def get_greedy_coin(amount, denominations)
      greedy_hash = {}

      denominations.each do |denomination|
        greedy_hash[denomination] = amount / denomination
      end

      greedy_hash.sort_by { |_key, value| value }.first
    end
  end
end
