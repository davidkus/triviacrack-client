require "spec_helper"

describe TriviaCrack::Client::Solvers::RandomAnswer do

  let(:user) { double(id: 111) }
  let(:game) { double(id: 1111) }
  let(:question) { double(correct_answer: 1) }
  let(:solver) { TriviaCrack::Client::Solvers::RandomAnswer.new }

  describe "#solve" do
    it "returns a random answer between 0 and 3" do
      expect(Random).to receive(:rand).with(0..3)

      solver.solve user, game, question
    end
  end

end
