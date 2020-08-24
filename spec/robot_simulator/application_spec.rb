# frozen_string_literal: true

require 'spec_helper'

describe Application do
  subject(:commands) { described_class::COMMANDS }

  let(:application) { described_class.new }

  it { is_expected.to be_a(Array) }
  it { is_expected.to include('PLACE', 'MOVE', 'REPORT', 'LEFT', 'RIGHT') }

  describe '#validate!' do
    subject(:validate!) { application.validate!(command) }
    let(:command) { 'MOVE' }

    it 'is valid' do
      expect { validate! }.not_to raise_error
    end

    context 'with invalid command' do
      let(:command) { 'RUN' }

      it 'raises CommandError' do
        expect { validate! }.to raise_error(ApplicationError)
      end
    end
  end

  describe '#place' do
    subject(:place) { application.place(x_axis, y_axis, direction) }

    let(:x_axis) { 4 }
    let(:y_axis) { 4 }
    let(:direction) { 'WEST' }

    it 'updates robot position on the board' do
      place
      expect(application.board.robot_position).to eq([x_axis, y_axis])
      expect(application.robot.direction).to eq(direction)
    end
  end

  describe '#move' do
    subject(:move) { application.move }

    before { application.place(0, 0, 'NORTH') }

    it 'moved the robot' do
      expect { move }.to change { application.board.robot_position }.from([0, 0]).to([0, 1])
    end
  end

  describe '#report' do
    subject(:report) { application.report }

    before { application.place(0, 0, 'NORTH') }

    it { is_expected.to eq('0,0,NORTH') }
  end

  describe '#left' do
    subject(:left) { application.left }

    before { application.place(0, 0, 'NORTH') }

    it 'rotates the robot 90 degress to the left' do
      expect { left }.to change { application.robot.direction }.from('NORTH').to('WEST')
    end
  end

  describe '#right' do
    subject(:right) { application.right }

    before { application.place(0, 0, 'NORTH') }

    it 'rotates the robot 90 degress to the right' do
      expect { right }.to change { application.robot.direction }.from('NORTH').to('EAST')
    end
  end
end
