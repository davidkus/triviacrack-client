# frozen_string_literal: true

require 'triviacrack'

require_relative 'client'
require_relative 'solvers/solver'

# Public: A TriviaCrack Client that automatically solves questions for all of
# the user's games.
module TriviaCrack
  module Client
    class Bot < TriviaCrack::Client::Client
      # Public: Runs the trivia bot, playing all currently available games to
      # completion.
      #
      # solver           - The name of a decision module to use
      # start_new_games  - A Boolean indacting whether or not to start new games
      #
      # Examples
      #
      #   trivia_bot = TriviaCrackBot::Bot.new username, session_id
      #   trivia_bot.play "CorrectAnswer", false
      #
      # Returns nothing.
      def play(solver, start_new_games)
        @solver = TriviaCrack::Client::Solvers.get_solver(solver)

        unless @solver.respond_to? :solve
          puts 'Solver does not have a solve method.'
          exit
        end

        puts "Starting to play Trivia Crack as #{@username}."

        loop do
          @user = @client.get_user

          start_new_game if @user.start_new_game? && start_new_games

          puts "Fetching games for #{@username}..."

          playable_games = @client.get_games.select(&:playable?)

          playable_games.each { |game| play_game game }

          puts 'No games available to play.' if playable_games.none?

          sleep POLL_TIME
        end
      end

      private

      # Internal: The amount of time to wait before checking for new games.
      POLL_TIME = 60

      # Internal: The maximum amount of time to wait between questions.
      QUESTION_DELAY_MAX = 10

      # Internal: The minimum amount of time to wait between questions.
      QUESTION_DELAY_MIN = 1

      # Internal: Plays the given game to completion.
      #
      # game   - TriviaCrack::Game.
      #
      # Examples
      #
      #   play_game game
      #
      # Returns nothing.
      def play_game(game)
        puts "Playing game #{game.id} against #{game.opponent.username}."

        while game.playable?
          # Sleep for a random number of seconds, so responses are not all
          # instantaneous and seem more natural.
          sleep_time = Random.rand(QUESTION_DELAY_MIN..QUESTION_DELAY_MAX)
          puts "\nWaiting #{sleep_time} seconds before the next question...\n\n"

          sleep sleep_time

          questions = game.questions.first.type == :duel ? game.questions : [game.questions.first]
          answers = {}

          questions.each do |question|
            answer = @solver.solve @user, game, question

            puts " Category : #{question.category}"
            puts " Question : #{question.text}"
            puts "   Answer : #{question.answers[answer]}"

            answers[question.id] = answer
          end

          begin
            game, results = @client.answer_questions game.id, questions, answers
          rescue Exception => e # rubocop:disable Lint/RescueException
            puts "\n#{game.inspect}" if @debug
            raise e
          end

          correct_answers = results.values.select { |v| v == true }.size
          puts "Correct Answers: #{correct_answers} / #{results.size}"
        end

        puts "\nFinished playing game #{game.id}. Status: #{game.game_status}."
      end
    end
  end
end
