# frozen_string_literal: true

module Midl
  module SparkSql
    # This class processes the MiDL Intermediate Rrepresentation query.
    class Query
      attr_reader :messages, :meta_data

      def initialize(meta_data)
        @meta_data = meta_data

        # process_meta_data
      end
    end
  end
end
