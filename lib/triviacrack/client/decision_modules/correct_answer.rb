require "triviacrack/question"

module TriviaCrack
  module Client
    module DecisionModules
      class CorrectAnswer

        def decide(user, game, question)
          question.correct_answer
        end

      end
    end
  end
end
