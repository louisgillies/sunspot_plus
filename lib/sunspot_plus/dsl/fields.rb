module Sunspot
  module DSL
    class Fields
      # NOTE : I want to call case_insensitive_sort using method missing but with adjusted name
      # Could use adjust_solr_params but not sure about this method.
      def sort_fields(*names, &block)
        options = names.last.is_a?(Hash) ? names.pop : {} 
        names.each do |name|
          field_options = {:using => name}.update(options)
          case_insensitive_sort( Sunspot::Type::CaseInsensitiveSortType.instance.field_name(name), field_options, &block)      
        end
      end
    end
  end
end