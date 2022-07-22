# frozen_string_literal: true

require 'spec_helper'

describe TriviaCrack::Client::Solvers::RandomAnswer do
  let(:user) { double(id: 111) }
  let(:game) { double(id: 1111) }
  let(:question) { double(correct_answer: correct_answer) }
  let(:solver) { TriviaCrack::Client::Solvers::RandomAnswer.new }

  describe '#solve' do
    subject { solver.solve user, game, question }

    context 'given Random returns a given number' do
      let(:correct_answer) { 2 }
      let(:random_number) { 1 }
      before { allow(Random).to receive(:rand).with(0..3).and_return random_number }

      it { is_expected.to be random_number }
    end
  end
end
