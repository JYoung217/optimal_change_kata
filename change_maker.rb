class ChangeError < StandardError; end

class ChangeMaker
  def self.make_change(amount, denominations = [1,5,10,25], coin_array = [])
    return coin_array if amount == 0
    raise ChangeError if denominations.size == 0

    denominations.reject! { |denomination| denomination > amount }

    optimal_coin_array = get_optimal_coin(amount, denominations)
    optimal_coin = optimal_coin_array.first

    denominations.delete(optimal_coin)

    optimal_coin_array.last.times do
      coin_array << optimal_coin
    end

    make_change(amount - calculated_difference(optimal_coin_array), denominations, coin_array)
  end

  def self.calculated_difference(coin_array)
    coin_array.first * coin_array.last
  end

  def self.get_optimal_coin(amount, denominations)
    denomination_divisor_hash = {}

    denominations.each do |denomination|
      denomination_divisor_hash[denomination] = amount / denomination
    end

    optimal_coins(denomination_divisor_hash)
  end

  def self.optimal_coins(hash)
    hash.sort_by { |_key, value| value }.first
  end
end
