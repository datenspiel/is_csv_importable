require File.dirname(__FILE__) + '/spec_helper'

class TestProduct < ActiveRecord::Base

  set_table_name "products"
  
  is_csv_importable!({:ex_von => :valid_thru_existence_from})
  
  csv_seperator ";"
end

class TestBoni < ActiveRecord::Base
  
  set_table_name "bonuses"
  
  is_csv_importable!
  
  csv_seperator ";"
end

describe IsCsvImportable do
  
  before(:each) do
    @test = TestProduct.new
  end
  
  it "should have an import method" do
    @test.methods.include?("import").should be true
  end
  
  it "should import a bunch of csv data" do
    file = File.dirname(__FILE__) + "/../test.csv"
    puts file
    @test.import(file).should be true
  end
  
end

describe IsCsvImportable, "without given hash" do
  
  before(:each) do
    @test = TestBoni.new
  end
  
  it "should import a bunch of csv data without given hash" do
    file = File.dirname(__FILE__) + "/../test_boni.csv"
    puts file
    @test.import(file).should be true
  end
end