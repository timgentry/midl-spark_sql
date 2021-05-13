# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

# For the SQLite3 adapter to behave more like Spark SQL, we need to remove column quoting
module ActiveRecord
  module ConnectionAdapters
    module SQLite3
      module Quoting # :nodoc:
        def quote_column_name(column_name)
          column_name.to_s
        end

        # Quotes the table name. Defaults to column name quoting.
        def quote_table_name(table_name)
          quote_column_name(table_name)
        end
      end
    end
  end
end

module Midl
  module SparkSql
    # This class processes the MiDL Intermediate Representation query.
    class Query
      attr_reader :messages, :meta_data

      def initialize(meta_data)
        raise unless meta_data.include?('table')

        @meta_data = meta_data

        table_name = meta_data.delete('table')[Midl::EQUALS]
        @data_table = Arel::Table.new(table_name)

        process_meta_data
      end

      def data_table
        @data_table = yield(@data_table)
      end

      def message=(text)
        @messages << text
      end

      def to_sql
        @data_table.project(Arel.star).to_sql
      end

      private

        def process_meta_data
          @meta_data.each do |canonical_name, filter|
            non_interval_keys = filter.keys - [:interval]
            raise "1 key expected #{filter.inspect}" if non_interval_keys.length != 1

            operation = non_interval_keys.first
            operand2 = filter[operation]

            Registry.fragment_for(canonical_name, operation, self, operand2)
          end
        end
    end
  end
end
