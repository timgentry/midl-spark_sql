# frozen_string_literal: true

require 'test_helper'

module Midl
  module SparkSql
    # These are tests of the handler registry
    class RegistryTest < Minitest::Test
      def test_registry_handlers
        assert_instance_of Hash, Registry.handlers
      end

      def test_should_fail_with_unknown_canonical_name
        exception = assert_raises(RuntimeError) do
          query = Query.new([])
          Registry.fragment_for('vegetable', Midl::EQUALS, query, 'cabbage')
        end

        assert_equal "Don't understand canonical_name vegetable", exception.message
      end

      def test_should_register_and_unregister
        Registry.register('test.vegetable', Midl::EQUALS) do |relation, operand2|
          relation.where(vegetable: operand2)
        end
        assert_includes Registry.handlers.keys, 'test.vegetable'
        assert_instance_of Proc, Registry.handlers['test.vegetable'][Midl::EQUALS]

        Registry.unregister('test.vegetable', Midl::EQUALS)
        refute_includes Registry.handlers.keys, 'test.vegetable'
      end

      # def test_should_work_with_known_canonical_name
      #   query = Query.new([])
      #   Registry.fragment_for('limit', Midl::EQUALS, query, 27)
      #   assert_equal ..., query.to_tumours.to_sql
      # end
    end
  end
end
