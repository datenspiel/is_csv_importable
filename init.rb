require File.join(File.dirname(__FILE__), "lib", "is_csv_importable")

require 'fastercsv'

ActiveRecord::Base.send(:include, IsCsvImportable)