# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/triviacrack/client/client'

require_relative '../lib/triviacrack/client/solvers/correct_answer'
require_relative '../lib/triviacrack/client/solvers/random_answer'
require_relative '../lib/triviacrack/client/solvers/solver'
