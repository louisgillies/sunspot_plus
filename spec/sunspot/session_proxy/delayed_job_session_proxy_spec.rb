require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sunspot::SessionProxy::DelayedJobSessionProxy do
  

  
  before(:each) do

    @original_session = Sunspot::Session.new
    @proxy = Sunspot::SessionProxy::DelayedJobSessionProxy.new( @original_session )
  end

  
  it "should wrap a current session" do
    @proxy.session.should == @original_session
  end
  
  context "methods that should be delegated to the default session" do
    ([:new_search, :search, :new_more_like_this, :more_like_this, :config, :index, 
      :delete_dirty?, :dirty?, :remove, :remove!, :remove_all, :remove_all!, :remove_by_id, :remove_by_id!]).each do |method|
      it "should delegate #{method.inspect} to its session" do
        args = Array.new(Sunspot::Session.instance_method(method).arity.abs) do
          stub('arg')
        end
        @proxy.session.should_receive(method).with(*args)
        @proxy.send(method, *args)
      end
    end
  end
  
  context "methods that commit should queue to delayed job." do
    describe "index" do 
      it "should delegate index to @session" do
        @proxy.session.should_receive(:index)
        @proxy.should_receive(:commit)
        @proxy.index!(mock("Model"))
      end
    end
    
    describe "commit_if_dirty" do  
      it "should delegate dirty? to @session" do
        @proxy.session.should_receive(:dirty?).and_return(true)
        @proxy.should_receive(:commit)
        @proxy.commit_if_dirty
      end
    end

    describe "commit_if_delete_dirty" do
      it "should delegate delete_dirty? to @session" do
        @proxy.session.should_receive(:delete_dirty?).and_return(true)
        @proxy.should_receive(:commit)
        @proxy.commit_if_delete_dirty
      end        
    end
  end
  
  context "methods that should be queued" do 
     [:commit, :batch].each do |method|
       it "should send #{method} to the delayed_job queue" do
         args = Array.new(Sunspot::Session.instance_method(method).arity.abs) do
           stub('arg')
         end
         Delayed::Job.should_receive(:enqueue)
         @proxy.send(method, *args)
       end
     end
  end
  
  it_should_behave_like 'session proxy'
end

