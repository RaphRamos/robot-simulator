# frozen_string_literal: true

require 'spec_helper'

shared_examples 'invalid direction' do
  let(:direction) { 'NORTHWEST' }

  it 'raises DirectionError' do
    expect { subject }.to raise_error(Direction::DirectionError)
  end
end

describe Direction do
  let(:direction) { 'NORTH' }

  describe '.validate!' do
    subject(:validate!) { described_class.validate!(direction) }

    it { is_expected.to be true }
    it_behaves_like 'invalid direction'
  end

  describe '.left_from' do
    subject(:left_from) { described_class.left_from(direction) }

    it { is_expected.to eq 'WEST' }
    it_behaves_like 'invalid direction'
  end

  describe '.right_from' do
    subject(:right_from) { described_class.right_from(direction) }

    it { is_expected.to eq 'EAST' }
    it_behaves_like 'invalid direction'

    context 'when is the last direction' do
      let(:direction) { described_class::DIRECTIONS.last }

      it { is_expected.to eq described_class::DIRECTIONS.first }
    end
  end
end
