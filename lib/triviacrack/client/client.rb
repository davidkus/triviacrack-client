require "triviacrack"

# Public: A base Trivia Crack client.
module TriviaCrack
  module Client
    class Client

      # Public: Initializes a TriviaCrack API Client and logs in with the given
      # email and password.
      def initialize(email, password)
        @client = TriviaCrack::API::Client.new
        session = @client.login(email, password)

        @user_id = session.user_id
        @username = session.username
      end

      private

      # Internal: Starts a new game.
      #
      # Examples
      #
      #   start_new_game
      #
      # Returns the TriviaCrack::Game that was started.
      def start_new_game
        say "\nStarting a new game."
        @client.start_new_game
      end

    end
  end
end
