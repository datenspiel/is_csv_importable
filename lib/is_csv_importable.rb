require 'is_csv_importable/errors.rb'

module IsCsvImportable  
  
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end
  
  module ClassMethods
    
    # adds the hash to a array
    def wrappers
      @wrappers ||= []
    end
    
    def is_csv_importable!(hash=nil)
      #raise IsCsvImportableHashNotFoundError if hash.nil?
      hash = {} if hash.nil?
      
      #hash is not empty 
      wrappers << hash
    end
    
    def csv_seperator(sep)
      define_method :col_sep do
        return sep
      end
    end
    
    
  end
  
  module InstanceMethods
  
    def import(file)
      csv_wrapper = self.class.wrappers.first
      if self.class.method_defined?(:col_sep) 
        seperator = col_sep
      else
        seperator = ","
      end
      return CsvImport.new(file).import(self,csv_wrapper,seperator)
    end
  end
  
end