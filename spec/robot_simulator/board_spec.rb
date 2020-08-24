# frozen_string_literal: true

require 'spec_helper'

shared_examples 'invalid board' do
  it 'raises ArgumentError' do
    expect { subject }.to raise_error(ArgumentError)
  end
end

describe Board do
  describe '.new' do
    subject(:board) { described_class.new }

    it { is_expected.to be_a(described_class) }

    it 'initializes with default values' do
      expect(board.dimension).to eq([5, 5])
    end

    context 'with negative dimensions' do
      subject(:board) { described_class.new(x_axis_size: 1, y_axis_size: -1) }

      it_behaves_like 'invalid board'
    end

    context 'with non Integer value' do
      subject(:board) { described_class.new(x_axis_size: 'a', y_axis_size: 1) }

      it_behaves_like 'invalid board'
    end

    context 'with 0 dimensions' do
      subject(:board) { described_class.new(x_axis_size: 0, y_axis_size: 0) }

      it_behaves_like 'invalid board'
    end
  end

  describe '#within_boundaries?' do
    subject(:within_boundaries?) { described_class.new.within_boundaries?(position) }

    let(:position) { [4, 4] }

    it { is_expected.to be true }

    context 'when x is out of boundaries' do
      let(:position) { [-1, 4] }

      it { is_expected.to be false }
    end

    context 'when y is out of boundaries' do
      let(:position) { [4, 6] }

      it { is_expected.to be false }
    end
  end

  describe '#update_robot_position' do
    subject(:board) { described_class.new }

    let(:position) { [4, 4] }

    it 'updates the robot position on the board' do
      expect { board.update_robot_position(position) }.to change { board.robot_position }.to(position)
    end

    context 'with invalid position' do
      let(:position) { [5, 4] }

      it 'silently fails' do
        expect { board.update_robot_position(position) }.not_to change { board.robot_position }
      end
    end
  end
end
