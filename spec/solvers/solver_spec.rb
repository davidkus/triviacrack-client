require "spec_helper"

describe TriviaCrack::Client::Solvers do

  let(:user) { double(id: 111) }
  let(:game) { double(id: 1111) }
  let(:question) { double(correct_answer: 1) }

  describe ".get_solver" do
    it "returns a CorrectAnswer solver" do
      solver = TriviaCrack::Client::Solvers.get_solver "CorrectAnswer"

      expect(solver).to be_a TriviaCrack::Client::Solvers::CorrectAnswer
    end

    it "returns a RandomAnswer solver" do
      solver = TriviaCrack::Client::Solvers.get_solver "RandomAnswer"

      expect(solver).to be_a TriviaCrack::Client::Solvers::RandomAnswer
    end
  end

end
