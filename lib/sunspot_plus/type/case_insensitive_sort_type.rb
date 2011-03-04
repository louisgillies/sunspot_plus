module Sunspot
  module Type
    # 
     # The CaseInsensitiveSort type represents string data optimised for case insensitve search.
     #
     class CaseInsensitiveSortType < StringType

       class << self
         def pattern
           @@pattern
         end
         
         def pattern=(value)
           @@pattern=value
         end
       end
       
       self.pattern = :downcase
        
       def pattern
         self.class.pattern
       end
       
       def indexed_name(name) #:nodoc:
         "#{name}_s"
       end
       
       def field_name(name)
         "case_insensitive_sort_#{name}"
       end
       
       def to_indexed(value) #:nodoc:
         if value
           if pattern.is_a?(Symbol)
             value.to_s.send(pattern) 
           elsif pattern.is_a?(Proc)
             pattern.call(value)
           end
         end
       end
     end
  end
end