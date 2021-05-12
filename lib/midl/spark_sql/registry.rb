module Midl
  module SparkSql
    # This mixin adds a canonical name registry.
    module Registry
      class <<self
        def register(canonical_name, predicate, &object_block)
          @handlers ||= {}
          @handlers[canonical_name] ||= {}
          @handlers[canonical_name][predicate]
          @handlers[canonical_name][predicate] = object_block
        end

        def unregister(canonical_name, predicate)
          @handlers[canonical_name].delete(predicate)
          @handlers.delete(canonical_name) if @handlers[canonical_name].empty?
        end

        def fragment_for(canonical_name, predicate, query, operand2)
          block_factory(canonical_name, predicate).call(query, operand2)
        end

        def handlers
          @handlers ||= {}
        end

        private

          def block_factory(canonical_name, predicate)
            canonical_name_handler = Registry.handlers[canonical_name]
            raise "Don't understand canonical_name #{canonical_name}" unless canonical_name_handler

            block = canonical_name_handler[predicate]
            raise "#{canonical_name} doesn't understand #{predicate.inspect}" unless block

            block
          end
      end
    end
  end
end

# %w[
# ].each { |handler| require_dependency File.join(__dir__, handler) }
