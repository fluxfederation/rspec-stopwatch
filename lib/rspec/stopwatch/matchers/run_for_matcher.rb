require 'active_support/core_ext/numeric/time'
require 'benchmark'

RSpec::Matchers.define :run_for do |time|
  [:<, :<=, :>, :>=].each do |operator|
    define_method(operator) do |expected|
      RunForComparedTo.new(operator, expected)
    end
  end

  class RunForComparedTo
    attr_reader :operator, :expected, :actual, :config

    def initialize(operator, expected)
      @operator, @expected = operator, expected.to_f

      @config = {
        :average_over => 10.times,
        :drop_first => 1,
      }
    end

    def matches?(block)
      raise ArgumentError, 'Expecting a block to `expect`' if !block.is_a?(Proc)

      begin
        warmup_runs.each { block.call }
        benchmark = Benchmark.measure { runs.each { block.call } }

        @actual = benchmark.total / runs.count
        @actual.in_milliseconds.send(operator, expected.in_milliseconds)
      rescue ArgumentError
        false
      end
    end

    def supports_block_expectations?
      true
    end

    def failure_message
      failure_message_for_operator(operator)
    end

    def failure_message_when_negated
      failure_message_for_operator(opposite_operator)
    end

    def description
      "run for #{operator} #{expected_str}"
    end

    private

    def runs
      config[:average_over]
    end

    def warmup_runs
      config[:drop_first].times
    end

    def failure_message_for_operator(operator)
      "expected: #{operator} #{expected_str}\n" \
      "     got: #{operator.to_s.gsub(/./, ' ')} #{actual_str}"
    end

    def opposite_operator
      { :< => :>=, :<= => :>, :> => :<=, :>= => :< }[operator]
    end

    def expected_str
      "#{expected.in_milliseconds} ms"
    end

    def actual_str
      "#{actual.in_milliseconds} ms"
    end
  end
end

