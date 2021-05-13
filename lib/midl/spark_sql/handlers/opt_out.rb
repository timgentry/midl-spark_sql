require 'midl/spark_sql/registry'
require 'arel/nodes'

module Midl
  module SparkSql
    # MiDL IR meta data handler for opt-outs
    module Handlers
      Registry.register('ignore_opt_out', Midl::ALL) do |query, operand2|
        query.data_table do |table|
          if operand2
            table
          else
            optouts = Arel::Table.new(:optouts)
            table.join(
              optouts, Arel::Nodes::OuterJoin
            ).on(table[:nhsnumber].eq(optouts[:nhsnumber])).where(optouts[:nhsnumber].eq(nil))
          end
        end
      end
    end
  end
end
