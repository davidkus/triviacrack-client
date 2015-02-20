require 'triviacrack'

require 'triviacrack/errors/request_error'

module TriviaCrack
  module Client
    class Client

      def initialize(email, password)
        begin
          @client = TriviaCrack::API::Client.new
          response = @client.login(email, password)
          @user_id = response[:user_id]
          @username = response[:username]
        rescue TriviaCrack::Errors::RequestError => e
          puts "Unable to log in to Trivia Crack server. Error: #{e.code}"
        end
      end

      private

      def display_question(question)
        puts " Category : #{question.category}"
        puts " Question : #{question.text}"
        puts ""
        puts "     0    : #{question.answers[0]}"
        puts "     1    : #{question.answers[1]}"
        puts "     2    : #{question.answers[2]}"
        puts "     3    : #{question.answers[3]}"
        puts ""
      end

      def prompt_for_answer
        print "Your Answer : "
        gets.chomp
      end

      def answer_question(game, question, answer)
        result = @client.answer_question game.id, question, answer
        print "You have answered #{question.answers[answer]} - "
        if result[:correct_answer]
          puts "You answered correctly!"
        else
          puts "You answered incorretly!"
        end
        result[:game]
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
