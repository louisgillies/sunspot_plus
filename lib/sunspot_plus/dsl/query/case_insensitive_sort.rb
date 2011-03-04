module SunspotPlus
  module DSL
    module Query
      module CaseInsensitiveSort
        def self.extended(base)
          base.send(:include, InstanceMethods)
        end
      
        module InstanceMethods
          def ci_order_by(field_name, direction = nil)
            order_by(Sunspot::Type::CaseInsensitiveSortType.instance.field_name(field_name), direction)
          end
        end
      end
    end
  end
end