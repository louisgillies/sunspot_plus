module Sunspot
  module DSL
    class Fields
      # NOTE : I want to call case_insensitive_sort using method missing but with adjusted name
      # Could use adjust_solr_params but not sure about this method.
      def sort_fields(*names, &block)
        options = names.pop if names.last.is_a?(Hash)
        names.each{|name| case_insensitive_sort(Sunspot::Type::CaseInsensitiveSortType.instance.field_name(name), {:as => name}, &block)}
      end
    end
  end
end