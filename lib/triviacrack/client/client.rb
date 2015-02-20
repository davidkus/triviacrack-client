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

    end
  end
end
