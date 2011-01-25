module Sunspot
  module SessionProxy
    #
    # Silently fail instead of raising an exception when an error occurs while writing to Solr.
    # NOTE: does not fail for reads; you should catch those exceptions, for example in a rescue_from statement.
    #
    # To configure, add this to an initializer:
    #    Sunspot.session = SilentFailSessionProxy.new(Sunspot.session)
    #
    # 
    #
    class SilentFailSessionProxy < Sunspot::SessionProxy::AbstractSessionProxy

      attr_reader :session
      delegate :new_search, :search, :configuration, :config, :to => :session

      [:index, :index!, :commit, :remove, :remove!, :remove_by_id,
       :remove_by_id!, :remove_all, :remove_all!, :dirty?, :commit_if_dirty, :batch].each do |method|
        module_eval(<<-RUBY)
          def #{method}(*args, &block)
            begin
              session.#{method}(*args, &block)
            rescue => e
              Rails.logger.error(e.message)
            end
          end
        RUBY
      end

      def initialize(session)
        @session = session
      end
    end
  end
end