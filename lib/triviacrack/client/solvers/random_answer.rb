# Internal: A Solver that solves the question by using a random number.
module TriviaCrack
  module Client
    module Solvers
      class RandomAnswer

        # Internal: Provides a random answer to the question.
        #
        # user      - TriviaCrack::User
        # game      - TriviaCrack::Game
        # question  - TriviaCrack::Question
        #
        # Examples
        #
        #   answer = solver.solve user, game, question
        #
        # Returns a random number between 0 and 3.
        def solve(user, game, question)
          Random.rand(0..3)
        end

      end
    end
  end
end
