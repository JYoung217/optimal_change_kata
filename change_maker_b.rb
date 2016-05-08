class ChangeError < StandardError; end

class ChangeMaker
  class << self
    def make_change(amount, denominations = [1,5,10,25])
      possible_permutations = []
      denominations.reject! { |denomination| denomination > amount }

      until denominations.size == 0
        possible_permutations << get_possible_permutation(amount, denominations.sort.reverse)
        denominations.pop
      end

      raise ChangeError if change_error?(amount, possible_permutations)
      possible_permutations.min_by { |permutation| permutation.size }
    end

    def get_possible_permutation(amount, denominations)
      permutation = []

      denominations.each do |denomination|
        divisible_times = amount / denomination
        if divisible_times > 0
          divisible_times.times do
            permutation << denomination
            amount -= denomination
          end
        end
      end

      permutation
    end

    def change_error?(amount, possible_permutations)
      possible_permutations.each do |permutation|
        return true if permutation.reduce(&:+) != amount
      end
      false
    end
  end
end

