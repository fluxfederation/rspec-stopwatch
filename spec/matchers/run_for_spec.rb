require 'rspec/stopwatch'

describe :run_for, :matcher => true do
  describe 'timing' do
    it 'reports comparisons correctly' do
      expect { 1000000.times { } }.to run_for > 0.001.seconds
    end

    it 'ignores real time' do
      expect { sleep(0.2) }.to run_for < 0.1.second
    end
  end

  describe 'success messages' do
    subject { RunForComparedTo.new(:<, 1.second) }

    before do
      subject.matches?(lambda { })
    end

    it 'includes the operator' do
      expect(subject.description).to include '<'
    end

    it 'includes the expectation time' do
      expect(subject.description).to include '1000.0 ms'
    end
  end

  describe 'failure messages' do
    subject { RunForComparedTo.new(:>, 1.second) }

    before do
      subject.matches?(lambda { })
    end

    it 'includes the operator' do
      expect(subject.failure_message).to include '>'
    end

    it 'includes the expected time' do
      expect(subject.failure_message).to include '1000.0 ms'
    end

    it 'includes the actual time' do
      expect(subject.failure_message).to include '0.0 ms'
    end

    context 'negated' do
      it 'includes the opposite operator' do
        expect(subject.failure_message_when_negated).to include '<='
      end
    end
  end

  describe 'error messages' do
    it "raises when a block isn't passed" do
      expect do
        expect(:pikachu).to run_for < 1.second
      end.to raise_error(ArgumentError).with_message 'Expecting a block to `expect`'
    end
  end
end

