require 'test_helper'

# These are tests of MiDL IR to SQL opt out filter
module Midl
  module SparkSql
    class OptOutTest < Minitest::Test
      def test_should_respect_opt_out
        parser = Midl::Parser.new('all journal records')
        assert_equal({ Midl::ALL => false }, parser.meta_data['ignore_opt_out'])
        assert_equal({ Midl::EQUALS => 'journal' }, parser.meta_data['table'])

        journal_table = Arel::Table.new(:journal)
        optout_table = Arel::Table.new(:optouts)
        relation = journal_table.project(Arel.star).join(optout_table, Arel::Nodes::OuterJoin).
                   on(journal_table[:nhsnumber].eq(optout_table[:nhsnumber])).
                   where(optout_table[:nhsnumber].eq(nil))

        assert_equal relation.to_sql,
                     Query.new(parser.meta_data).to_sql
      end

      def test_should_ignore_opt_out
        parser = Midl::Parser.new('all patients records, but do not apply opt-outs')
        assert_equal({ Midl::ALL => true }, parser.meta_data['ignore_opt_out'])

        assert_equal Arel::Table.new(:patients).project(Arel.star).to_sql,
                     Query.new(parser.meta_data).to_sql
      end
    end
  end
end
