# Optimal Change Kata

The optimal change problem is a classic example of a recursive algorithm. I decided at the beginning to pseudocode the answer before writing any code to give myself a chance to "think out loud" and have a roadmap of where to go. The solution I decided to go with would keep track of the denominations that were already tried and keep a running balance of the amount after a valid denomination was used. With this, I knew that I needed to add a third parameter and recursively call the `make_change` method.

I came to an initial solution but realized quickly that my solution was a greedy one and not the true solution that gave out optimal change. "First things first," I thought. "I have to get this to raise an exception if you can't make an amount from the denominations given." I spent the next few minutes trying to incorporate the raising of an error within the code I had written when it dawned on me that all I needed to do was add another escape case after the first escape case of returning the `coin_array` when the running balance, `amount`, reached 0. If the running balance wasn't 0 but there weren't any more denominations, that would prove that you couldn't make change with the denominations given.

I am still in the process of working through the true optimal change solution which I believe has something to do with keeping an array of arrays of possible permutations and choosing the smallest one. This repo will be updated when that is completed.

## Update: I solved the optimal change problem

See `change_maker_b.rb` for this solution and call `change_maker_spec_b.rb` to ensure that it works!

It turns out that you don't need to recursively call any method to solve the optimal change problem if you don't worry about performance - you can brute force all the possible combinations and choose the smallest combination and return that as your answer.
