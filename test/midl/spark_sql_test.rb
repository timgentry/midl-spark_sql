# frozen_string_literal: true

require 'test_helper'

module Midl
  class SparkSqlTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Midl::SparkSql::VERSION
    end
  end
end
