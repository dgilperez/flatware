require 'cucumber'
require 'flatware/cucumber/runtime'
require 'flatware/cucumber/checkpoint'
require 'flatware/cucumber/result'
require 'flatware/cucumber/scenario_decorator'
require 'flatware/cucumber/scenario_result'
require 'flatware/cucumber/step_result'

module Flatware
  module Cucumber

    extend self

    attr_reader :jobs

    def extract_jobs_from_args(args=[], out_stream=$stdout, error_stream=$stderr)
      raw_args = args.dup
      config = ::Cucumber::Cli::Configuration.new(out_stream, error_stream)
      config.parse! args
      options = raw_args - args
      @jobs = config.feature_files.map { |file| Job.new file, options }
    end

    def run(job)
      runtime.run job.id, job.args
    end

    def runtime
      @runtime ||= Runtime.new
    end
  end
end
