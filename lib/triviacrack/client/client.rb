require "triviacrack"

# Public: A base Trivia Crack client.
module TriviaCrack
  module Client
    class Client

      # Public: Initializes a TriviaCrack API Client and logs in with the given
      # email and password.
      def initialize(email, password)
        begin
          @client = TriviaCrack::API::Client.new
          @user_id, @username = @client.login(email, password)
        rescue TriviaCrack::Errors::RequestError => e
          puts "Unable to log in to Trivia Crack server. Error: #{e.code}"
          exit
        end
      end

      private

      # Internal: Starts a new game.
      #
      # Examples
      #
      #   start_new_game
      #
      # Returns nothing.
      def start_new_game
        say "\nStarting a new game."
        @client.start_new_game
      end

    end
  end
end
