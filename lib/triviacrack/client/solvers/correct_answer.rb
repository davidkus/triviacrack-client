# frozen_string_literal: true

# Internal: A Solver that solves the question using the correct answer.
module TriviaCrack
  module Client
    module Solvers
      class CorrectAnswer
        # Internal: Provides the correct answer to be used to solve the question.
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
        def solve(_user, _game, question)
          question.correct_answer
        end
      end
    end
  end
end
