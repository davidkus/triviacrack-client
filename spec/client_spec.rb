require "spec_helper"

describe TriviaCrack::Client::Client do

  before { allow(TriviaCrack::API::Client).to receive(:new) { api_client } }
  before { allow(api_client).to receive(:login) { [user_id, username] } }

  let(:client) { TriviaCrack::Client::Client.new email, password }

  let(:email) { "user@example.com" }
  let(:password) { "password123" }

  let(:session) { double(user_id: user_id, username: username) }

  let(:user_id) { 123 }
  let(:username) { "example" }

  let(:api_client) { double() }

  describe '.initialize' do

    subject { client }

    context 'given that the login in successful' do
      before { allow(api_client).to receive(:login) { session } }

      specify { expect(client.instance_variable_get :@client).to be api_client }
      specify { expect(client.instance_variable_get :@user_id).to be user_id }
      specify { expect(client.instance_variable_get :@username).to eq username }
    end

    context 'given that the login fails' do
      before { allow(api_client).to receive(:login).and_raise TriviaCrack::Errors::RequestError, 400 }

      specify { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
    end
  end
end
