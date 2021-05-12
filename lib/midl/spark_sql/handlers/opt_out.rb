require 'midl/spark_sql/registry'
require 'arel/nodes'

module Midl
  module SparkSql
    # MiDL IR meta data handler for opt-outs
    module Handlers
      Registry.register('ignore_opt_out', Midl::ALL) do |query, operand2|
        query.patient_table do |patient|
          if operand2
            patient
          else
            optouts = Arel::Table.new(:optouts)
            patient.join(
              optouts, Arel::Nodes::OuterJoin
            ).on(patient[:nhsnumber].eq(optouts[:nhsnumber])).where(optouts[:nhsnumber].eq(nil))
          end
        end
      end
    end
  end
end
