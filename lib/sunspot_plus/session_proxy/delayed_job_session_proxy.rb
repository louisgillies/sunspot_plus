module Sunspot
  module SessionProxy
    #
    # Queue commits to delayed_job.
    # 
    #
    # To configure, add this to an initializer:
    #    Sunspot.session = DelayedJobSessionProxy.new(Sunspot.session)
    #
    #
    
    class DelayedJobSessionProxy < Sunspot::SessionProxy::AbstractSessionProxy
      
      attr_reader :session
      attr_writer :config
      
      delegate :new_search, :search, :new_more_like_this, :more_like_this, :config, :index,
        :delete_dirty?, :dirty?, :remove, :remove!, :remove_all, :remove_all!, :remove_by_id, :remove_by_id!, 
        :to => :session   
      
      def batch(&block)
        Delayed::Job.enqueue Sunspot::SessionProxy::DelayedJob::IndexingJob.new(self, :batch, &block)
      end
            
      def commit
        Delayed::Job.enqueue Sunspot::SessionProxy::DelayedJob::IndexingJob.new(self, :commit)
      end
      
      # 
      # We can't delegate to @session as commit needs to be sent to delayed job.
      #
      def index!(*objects)
        @session.index(*objects)
        commit
      end
      # 
      # We can't delegate to @session as commit needs to be sent to delayed job.
      #
      def commit_if_dirty
        commit if @session.dirty?
      end
      
      # 
      # We can't delegate to @session as commit needs to be sent to delayed job.
      #
      def commit_if_delete_dirty
        commit if @session.delete_dirty?
      end
      
      def self.rebuild_config(config)
        Sunspot::SessionProxy::DelayedJob::SafeConfiguration.new(config)
      end
      
      def initialize(session)
        @config = session.config
        @session = session
      end
      
    end
  end
end