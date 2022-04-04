# frozen_string_literal: true

absolute_path = File.expand_path(__dir__)
dirs = Dir["#{absolute_path}/*/"]

$LOAD_PATH.concat(dirs) unless $LOAD_PATH.include?(dirs)
