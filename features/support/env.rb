require 'aruba/cucumber'
require 'methadone/cucumber'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  @aruba_timeout_seconds = 20
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
end

When /^You successfully run `([^`]*)`$/ do |cmd|
  puts "omg"
  puts `#{cmd}`
  puts "done"
end


def run_simple command
  puts "Running command"
  puts `#{command}`
end

After do
  ENV['RUBYLIB'] = @original_rubylib
end

Before('@simulate-capture') do
  @original_fakecapture = ENV['LOLCOMMITS_FAKECAPTURE']
  ENV['LOLCOMMITS_FAKECAPTURE'] = "1"

  @original_loldir = ENV['LOLCOMMITS_DIR']
  ENV['LOLCOMMITS_DIR'] = File.join(current_dir, ".lolcommits")
  puts ENV['LOLCOMMITS_DIR']
end

After('@simulate-capture') do
  ENV['LOLCOMMITS_FAKECAPTURE'] = @original_fakecapture
  ENV['LOLCOMMITS_DIR'] = @original_loldir
end
