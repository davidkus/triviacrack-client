require "highline/import"
require "triviacrack"

require_relative "client"

# Public: A TriviaCrack Client that lets you play the game manually.
module TriviaCrack
  module Client
    class Manual < TriviaCrack::Client::Client

      # Public: The main game loop.
      #
      # Examples
      #
      #   trivia_bot = TriviaCrackBot::Manual.new username, session_id
      #   trivia_bot.play
      #
      # Returns nothing.
      def play
        begin
          loop do
            @user = @client.get_user

            show_main_menu
          end
        rescue TriviaCrack::Errors::RequestError => e
          puts "Request to the Trivia Crack API failed with code #{e.code}"
        end
      end

      private

      # Public: Shows the main menu.
      #
      # Returns nothing.
      def show_main_menu
        choose do |menu|
          menu.header = "\n@#{@user.username} - Lives: #{@user.lives}  " <<
                        "~  Level: #{@user.level}"

          menu.choice("List Games : My Turn") { list_games_my_turn }

          menu.choice("List Games : Their Turn") { list_games_their_turn }

          menu.choice("List Games : Finished Games") { list_games_finished }

          if @user.start_new_game?
            menu.choice("Start New Game") { start_new_game }
          end

          menu.choice("Quit") { exit }
        end
      end

      # Public: Lists the games that are currently available for the user to
      # play.
      #
      # Returns nothing.
      def list_games_my_turn
        playable_games = @client.get_games.select { |game| game.playable? }

        if playable_games.none?
          say "\nThere are no games to play."
          return
        end

        choose do |menu|
          menu.header = "\nSelect a game to play"

          playable_games.each do |game|
            menu.choice(game_text game) { play_game game }
          end

          menu.choice "Cancel"
        end
      end

      # Public: Lists the games that are waiting for the opponent.
      #
      # Returns nothing.
      def list_games_their_turn
        other_games = @client.get_games.select do |game|
          !game.playable? && game.game_status != :ended
        end

        if other_games.any?
          say "\n"
          other_games.each { |game| say(game_text game) }
        else
          say "\nThere are no games waiting."
        end
      end

      # Public: Lists the games that are finished.
      #
      # Returns nothing.
      def list_games_finished
        finished_games = @client.get_games.select do |game|
          game.game_status == :ended
        end

        if finished_games.any?
          say "\n"
          finished_games.each { |game| say(game_text game) }
        else
          say "\nThere are no finished games."
        end
      end

      # Public: The text representation for a game.
      #
      # game   - TriviaCrack::Game.
      #
      # Returns a string of the text representation of the game.
      def game_text(game)
        "Game #{game.id} - Versus @#{game.opponent.username}"
      end

      # Public: Lists the available crowns.
      #
      # game   - TriviaCrack::Game.
      #
      # Returns the category selected, and a boolean indacting whether to keep
      # playing.
      def list_categories(game)
        keep_playing = true
        result = :none

        choose do |menu|
          menu.header = "\nSelect a category"

          game.available_crowns.each do |crown|
            menu.choice(crown) { result = crown }
          end

          menu.choice("Cancel") { keep_playing = false }
        end

        [result, keep_playing]
      end

      # Public: Asks the question to the user.
      #
      # question   - TriviaCrack::Question.
      #
      # Returns the selected answer, and a boolean indicating whether to keep
      # playing.
      def ask_question(question)
        keep_playing = true
        answer = -1

        choose do |menu|
          header_text = "\nCategory: #{question.category}" <<
                        "\nQuestion: #{question.text}"

          if question.media_type == :image
            header_text << "\nImage URL: #{question.image_url}"
          end

          menu.header = header_text

          question.answers.each_index do |i|
            menu.choice question.answers[i] { answer = i }
          end

          menu.choice("Cancel") { keep_playing = false }
        end

        [answer, keep_playing]
      end

      # Public: Submits the answer and displays whether or not it was answered
      # correctly.
      #
      # game       - TriviaCrack::Game.
      # question   - TriviaCrack::Question.
      # answer     - The index of the answer to submit.
      #
      # Returns the updated TriviaCrack::Game.
      def submit_answer(game, question, answer)
        game, result = @client.answer_question game.id, question, answer
        correct_answer = question.correct_answer

        if result
          say "\nYour answer is correct!"
        else
          say "\nYour answer is incorrect!"
          say "The correct answer is #{question.answers[correct_answer]}"
        end

        game
      end

      # Internal: Plays the given game.
      #
      # game   - TriviaCrack::Game.
      #
      # Examples
      #
      #   play_game game
      #
      # Returns nothing.
      def play_game(game)
        say "\nPlaying game #{game.id} against #{game.opponent.username}."

        keep_playing = true

        while game.playable? && keep_playing do

          if game.questions.first.type == :crown
            crown, keep_playing = list_categories game

            break if !keep_playing

            question = game.questions.select { |q| q.category == crown }.first
          else
            question = game.questions.first
          end

          answer, keep_playing = ask_question question

          if keep_playing
            game = submit_answer game, question, answer
          end
        end

        say "\nDone playing game #{game.id}. Status: #{game.game_status}."
      end

    end
  end
end
