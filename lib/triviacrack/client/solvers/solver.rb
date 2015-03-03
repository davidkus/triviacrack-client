require "triviacrack/client/solvers/correct_answer"
require "triviacrack/client/solvers/random_answer"

module TriviaCrack
  module Client
    module Solvers

      # Public: Gets the solver by name.
      #
      # name  - The name of the solver.
      #
      # Returns the appropriate solver.
      def self.get_solver(name)
        full_name = "TriviaCrack::Client::Solvers::#{name}"
        clazz = full_name.split('::').inject(Object) { |o,c| o.const_get c }
        clazz.new
      end

    end
  end
end
