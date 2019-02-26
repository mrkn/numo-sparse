#! /usr/bin/env ruby

$VERBOSE = true

require 'test/unit'

test_dir = File.expand_path('..', __FILE__)
lib_dir = File.expand_path('../lib', test_dir)
$LOAD_PATH.unshift(lib_dir)

require_relative 'test_helper'

ENV["TEST_UNIT_MAX_DIFF_TARGET_STRING_SIZE"] ||= "10000"

exit(Test::Unit::AutoRunner.run(true, test_dir))
