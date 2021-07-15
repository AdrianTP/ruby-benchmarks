class BaseTestCase
  attr_reader :x

  ITERATIONS = 50_000.freeze

  def initialize(x)
    @x = x
  end

  def once(label: self.class::LABEL, run_opts: {})
    x.report(label) do
      run(run_opts)
    end
  end

  def lots(label: self.class::LABEL, iterations: ITERATIONS, run_opts: {})
    x.report(label) do
      iterations.times do
        run(run_opts)
      end
    end
  end

  protected

  def run(*_)
    raise NotImplementedError
  end

  private

  def label(type = nil)
    return self.class::LABEL if type.nil?

    "#{self.class::LABEL}: #{type}"
  end

end
