require "spec_helper"

describe TriviaCrack::Client::Solvers::CorrectAnswer do

  let(:user) { double(id: 111) }
  let(:game) { double(id: 1111) }
  let(:question) { double(correct_answer: 1) }
  let(:solver) { TriviaCrack::Client::Solvers::CorrectAnswer.new }

  describe "#solve" do
    it "returns the correct answer to the question" do
      answer = solver.solve user, game, question

      expect(answer).to be(1)
    end
  end

end
