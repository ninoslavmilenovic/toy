# encoding: utf-8

require 'spec_helper'

describe Toy::Controller do
  let(:controller) { Toy::Controller.new }

  describe '#start' do
    context 'on invalid command' do
      before { allow(controller).to receive(:gets).and_return('INVALID', 'STOP') }

      specify do
        expect { controller.start }.to output("Invalid command! Type HELP for list of available commands.\n").to_stdout
      end
    end

    context 'on HELP' do
      before { allow(controller).to receive(:gets).and_return('HELP', 'STOP') }

      specify do
        expect { controller.start }.to output("Available commands: STOP HELP PLACE MOVE LEFT RIGHT REPORT\n").to_stdout
      end
    end

    context 'on PLACE' do
      context 'when valid arguments' do
        before { allow(controller).to receive(:gets).and_return('PLACE 1,1,NORTH', 'STOP') }

        specify do
          controller.start
          expect(controller.robot.position).to eq([1, 1, :north]) 
        end
      end

      context 'when invalid coordinates' do
        before { allow(controller).to receive(:gets).and_return('PLACE 1,INVALID,NORTH', 'STOP') }

        specify do
          expect { controller.start }.to output("Coordinates must be of type Fixnum!\n").to_stdout
        end
      end

      context 'when invalid direciton' do
        before { allow(controller).to receive(:gets).and_return('PLACE 1,1,INVALID', 'STOP') }

        specify do
          expect { controller.start }.to output("Invalid direction!\n").to_stdout
        end
      end

      context 'when invalid arguments' do
        before { allow(controller).to receive(:gets).and_return('PLACE 1,INVALID', 'STOP') }

        specify do
          expect { controller.start }.to output("Invalid placement arguments!\n").to_stdout
        end
      end

      context 'when unit is taken' do
        before { allow(controller).to receive(:gets).and_return('PLACE 1,1,NORTH','PLACE 1,1,NORTH', 'STOP') }

        specify do
          expect { controller.start }.to output("Already taken!\n").to_stdout
        end
      end

      context 'when arguments are missing' do
        before { allow(controller).to receive(:gets).and_return('PLACE INVALID', 'STOP') }

        specify do
          expect { controller.start }.to output("Invalid placement arguments!\n").to_stdout
        end
      end
    end

    context 'on MOVE' do
      before { allow(controller).to receive(:gets).and_return('MOVE', 'STOP') }

      context 'when placed' do
        context 'when unit is available' do
          before { controller.robot.place(0, 0, :north) }

          specify do
            controller.start
            expect(controller.robot.position).to eq([0, 1, :north]) 
          end
        end

        context 'when unit is not available' do
          before { controller.robot.place(0, 0, :south) }

          specify do
            controller.start
            expect(controller.robot.position).to eq([0, 0, :south]) 
          end
        end
      end

      context 'when not placed' do
        specify do
          expect { controller.start }.to output("Robot is not placed!\n").to_stdout
        end
      end
    end

    context 'on LEFT' do
      before { allow(controller).to receive(:gets).and_return('LEFT', 'STOP') }

      context 'when placed' do
        before { controller.robot.place(0, 0, :north) }

        specify do
          controller.start
          expect(controller.robot.facing).to eq(:west) 
        end
      end

      context 'when not placed' do
        specify do
          expect { controller.start }.to output("Robot is not placed!\n").to_stdout
        end
      end
    end

    context 'on RIGHT' do
      before { allow(controller).to receive(:gets).and_return('RIGHT', 'STOP') }

      context 'when placed' do
        before { controller.robot.place(0, 0, :north) }

        specify do
          controller.start
          expect(controller.robot.facing).to eq(:east) 
        end
      end

      context 'when not placed' do
        specify do
          expect { controller.start }.to output("Robot is not placed!\n").to_stdout
        end
      end
    end

    context 'on REPORT' do
      before { allow(controller).to receive(:gets).and_return('REPORT', 'STOP') }

      context 'when placed' do
        before { controller.robot.place(0, 0, :north) }

        specify do
          expect { controller.start }.to output("0,0,NORTH\n").to_stdout
        end
      end

      context 'when not placed' do
        specify do
          expect { controller.start }.to output("Robot is not placed!\n").to_stdout
        end
      end
    end
  end
end
