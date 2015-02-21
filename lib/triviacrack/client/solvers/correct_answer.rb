require "triviacrack/question"

module TriviaCrack
  module Client
    module Solvers
      class CorrectAnswer

        # Public: Provides the correct answer to be used to solve the question.
        #
        # user      - TriviaCrack::User
        # game      - TriviaCrack::Game
        # question  - TriviaCrack::Question
        #
        # Examples
        #
        #   answer = solver.solve user, game, question
        #
        # Returns an integer representing the index of the correct answer.
        def solve(user, game, question)
          question.correct_answer
        end

      end
    end
  end
end
