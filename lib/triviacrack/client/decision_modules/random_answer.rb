require "triviacrack/question"

module TriviaCrack
  module Client
    module DecisionModules
      class RandomAnswer

        def decide(user, game, question)
          Random.rand(0..3)
        end

      end
    end
  end
end
