# frozen_string_literal: true

require 'spec_helper'

describe TriviaCrack::Client::Solvers do
  describe '.get_solver' do
    subject { TriviaCrack::Client::Solvers.get_solver solver_name }

    context 'given that we request a CorrectAnswer solver' do
      let(:solver_name) { 'CorrectAnswer' }

      it { is_expected.to be_a TriviaCrack::Client::Solvers::CorrectAnswer }
    end

    context 'given that we request a RandomAnswer solver' do
      let(:solver_name) { 'RandomAnswer' }

      it { is_expected.to be_a TriviaCrack::Client::Solvers::RandomAnswer }
    end
  end
end
