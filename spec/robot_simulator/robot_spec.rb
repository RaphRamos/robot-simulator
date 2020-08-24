# frozen_string_literal: true

require 'spec_helper'

describe Robot do
  describe '.new' do
    subject(:robot) { described_class.new }

    it { is_expected.to be_a(described_class) }

    it 'initializes with default values' do
      expect(robot.direction).to eq(Direction::DIRECTIONS.first)
    end

    context 'with invalid initial direction' do
      subject(:robot) { described_class.new(direction: 'BLAH') }

      it 'raises DirectionError' do
        expect { robot }.to raise_error(Direction::DirectionError)
      end
    end
  end

  describe '#move' do
    subject(:move) { described_class.new(direction: direction).move_from(position) }
    let(:position) { [0, 0] }
    let(:direction) { 'NORTH' }
    let(:new_position) { [0, 1] }

    it { is_expected.to eq(new_position) }

    context 'when facing EAST' do
      let(:direction) { 'EAST' }
      let(:new_position) { [1, 0] }

      it { is_expected.to eq(new_position) }
    end

    context 'when facing SOUTH' do
      let(:position) { [1, 1] }
      let(:direction) { 'SOUTH' }
      let(:new_position) { [1, 0] }

      it { is_expected.to eq(new_position) }
    end

    context 'when facing WEST' do
      let(:position) { [1, 1] }
      let(:direction) { 'WEST' }

      it { is_expected.to eq(new_position) }
    end
  end
end
