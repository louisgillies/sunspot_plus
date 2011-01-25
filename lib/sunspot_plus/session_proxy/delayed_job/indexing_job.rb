module Sunspot
  module SessionProxy
    #
    # Queue indexing to job.
    #
    #
    
    module DelayedJob
      class IndexingJob

        attr_reader :session, :proxy, :method
        
        def initialize(proxy, method, *args, &block)
          @session = proxy.session
          @proxy = proxy
          @method = method
          @args = args
        end

        def rebuild_config
          @session.instance_variable_set("@config", proxy.class.rebuild_config(session.config))
        end

        def perform
          # Delayed job serializes ruby objects to yaml.
          # Yaml doesn't rebuild the LightConfiguration object correctly so we need to brute force a rebuild of the configuration
          rebuild_config
          @args ? @session.send(method, *@args) : @session.send(method)
        end
      end
    end
  end
end