require "triviacrack"
require "triviacrack/client/client"
require "triviacrack/client/decision_modules/decision_module.rb"

module TriviaCrack
  module Client
    class Bot < TriviaCrack::Client::Client

      # Public: Runs the trivia bot, playing all currently available games to
      # completion.
      #
      # Examples
      #
      #   trivia_bot = TriviaCrackBot::Bot.new username, session_id
      #   trivia_bot.play
      #
      # Returns nothing.
      def play(decision_module, start_new_games)
        @decision_module =
          TriviaCrack::Client::DecisionModules.get_module(decision_module)

        begin
          puts "Starting to play Trivia Crack as #{@username}."

          while true do
            puts "Updating user information..."
            @user = @client.get_user

            if @user.start_new_game? && start_new_games
              start_new_game
            end

            games = @client.get_games

            games.each do |game|
              if game.playable?
                play_game game
              end
            end

            sleep 60
          end
        rescue TriviaCrack::Errors::RequestError => e
          puts "Request to the Trivia Crack API failed with code #{e.code}"
        end
      end

      private

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
        while game.playable? do
          # Sleep for a random number of seconds, so responses are not all
          # instantaneous and seem more natural.
          sleep_time = Random.rand(1..10)
          puts "\nWaiting #{sleep_time} seconds before the next question...\n\n"
          sleep(sleep_time)

          question = game.questions.first
          answer = @decision_module.decide(@user, game, question)

          puts " Category : #{question.category}"
          puts " Question : #{question.text}"
          print "   Answer : #{question.answers[answer]} "

          result = @client.answer_question game.id, question, answer

          if result[:correct_answer]
            puts "You answered correctly!"
          else
            puts "You answered incorretly!"
          end

          game = result[:game]
        end
        puts "Finished playing game #{game.id}. Status: #{game.game_status}."
      end

      # Internal: Starts a new game.
      #
      # Examples
      #
      #   start_new_game
      #
      # Returns nothing.
      def start_new_game
        puts "Starting a new game."
        @client.start_new_game
      end

    end
  end
end
