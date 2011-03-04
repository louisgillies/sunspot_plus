require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

class SomethingToIndex
  def name
    "something"
  end
  
  def description
    "description"
  end
  
  def another
    "another"
  end
end

describe Sunspot::Type::CaseInsensitiveSortType do
  
  before(:each) do
    @sort_type = Sunspot::Type::CaseInsensitiveSortType.instance
  end
  
  it "should have an indexed name" do
    @sort_type.indexed_name(:test).should == "sort_test_s"
  end
  
  it "should convert a field attribute into a case insensitive field name" do
    @sort_type.field_name(:test).should == "case_insensitive_sort_test"
  end
  
  it "should make the value lowercase" do
    @sort_type.to_indexed("This is a sort term that needs to be Case Insensitive").should == "this is a sort term that needs to be case insensitive"
  end
  
  it "should case the value to a string" do
    @sort_type.cast("string").should == "string" 
    @sort_type.cast("sting").should be_a(String)
  end
  
  describe "if i want to defined another pattern" do
    before(:each) do
      Sunspot::Type::CaseInsensitiveSortType.pattern = :upcase
    end
    
    it "should use upcase to transform the value" do
      Sunspot::Type::CaseInsensitiveSortType.instance.pattern.should == :upcase
      @sort_type.to_indexed("This is a sort term that needs to be Case Insensitive").should == "THIS IS A SORT TERM THAT NEEDS TO BE CASE INSENSITIVE"
    end
    
    context "using a proc" do
      before(:each) do
        Sunspot::Type::CaseInsensitiveSortType.pattern = Proc.new{|value| value << "999"}
      end
      
      it "should get rid of an and and the and upcase" do
        Sunspot::Type::CaseInsensitiveSortType.instance.pattern.should be_a(Proc)
        @sort_type.to_indexed("Please call ").should == "Please call 999"
      end
    end
  end
  
  describe "using the type" do
    before(:each) do
      Sunspot.setup(SomethingToIndex) do
        string :name
        sort_fields :name
        sort_fields :description, :another
      end
      @something = SomethingToIndex.new
    end
    
    it "should index something_to_index with sort field" do
      Sunspot.search(SomethingToIndex) do
        keywords "something"
        order_by((:case_insensitive_sort_name))
      end
      Sunspot.session.should have_search_params(:order_by, :case_insensitive_sort_name, :asc)
    end
    
    describe "the ci_order method" do
      it "should add a new ci_order_by method" do
        Sunspot.search(SomethingToIndex) do
          keywords "bobbins"
          ci_order_by(:name)
        end
        Sunspot.session.should have_search_params(:order_by, :case_insensitive_sort_name, :asc)
      end
      
      it "should allow the direction to be changed" do
        Sunspot.search(SomethingToIndex) do
          keywords "bobbins"
          ci_order_by(:description, :desc)
        end
        Sunspot.session.should have_search_params(:order_by, :case_insensitive_sort_description, :desc)
      end
      
    end
  end
  
end
  
