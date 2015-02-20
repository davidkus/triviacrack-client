require "triviacrack/client/decision_modules/correct_answer"
require "triviacrack/client/decision_modules/random_answer"

module TriviaCrack
  module Client
    module DecisionModules

      def self.get_module(name)
        full_name = "TriviaCrack::Client::DecisionModules::#{name}"
        clazz = full_name.split('::').inject(Object) { |o,c| o.const_get c }
        clazz.new
      end

    end
  end
end
