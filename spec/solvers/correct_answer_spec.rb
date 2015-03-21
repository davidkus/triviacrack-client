require "spec_helper"

describe TriviaCrack::Client::Solvers::CorrectAnswer do

  let(:user) { double(id: 111) }
  let(:game) { double(id: 1111) }
  let(:question) { double(correct_answer: correct_answer) }
  let(:solver) { TriviaCrack::Client::Solvers::CorrectAnswer.new }

  describe '#solve' do

    subject { solver.solve user, game, question }

    context 'given a question with a correct answer' do
      let(:correct_answer) { 1 }

      it { is_expected.to be correct_answer }
    end
  end
end
