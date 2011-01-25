
module Sunspot
  module SessionProxy
    module DelayedJob
      
      # Problems arise when trying to load a yaml serialised sunspot config
      # The recursive properties set up from the build blocks can't be accessed and the methods raise a not defined error.
      # To see an example of this.
      #   config = Sunspot::Configuration.build 
      #   config.solr.url => "http://127.0.0.1:8983/solr"
      #   YAML.load(YAML.dump(config).solr.url => undefined method solr raised.
      # This class will attempt to wrap and rebuild the original config and create a safe version of it.
      class SafeConfiguration
        def initialize(config)
          @config = config
          singleton = (class <<self; self; end)
          @properties = @config.instance_variable_get("@properties") || {}
          @properties.keys.each do |property|
            singleton.module_eval do
              define_method property do
                if @properties[property].is_a?(LightConfig::Configuration)
                  self.class.new(@properties[property])
                else
                  @properties[property]
                end
              end
              define_method "#{property}=" do |value|
                @properties[property] = value
              end
            end
          end
        end        
      end
    end
  end
end