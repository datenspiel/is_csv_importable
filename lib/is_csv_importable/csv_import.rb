module IsCsvImportable

  class CsvImport
  
    def initialize(file)
      @file = file
    end
    
    #
    # returns true if import works, otherwise false
    #
    def import(obj,wrappers,sep)
      $KCODE = "utf8"
      saved = false
      
      FasterCSV.parse(File.read(@file), :headers => true, :col_sep => sep) do |row|
        
        k = row.to_hash
        #puts k.inspect
        unless wrappers.empty?
          instance = obj.class.new
          wrappers.each_pair do |key,val|
            #puts "row has key? #{k.has_key?(key.to_s)}"
            #puts "key,val for wrapper #{key},#{val}"
            puts "#{k[key.to_s].nil?}, #{val}"
            unless k[key.to_s].nil?
              instance.send("#{val}=", k[key.to_s]) 
            else
              puts "save nothing."
            end
            #puts "key as string #{key.to_s}"
            
          end
        else
          instance = obj.class.new(k)
        end
        
        saved = instance.save
        #puts saved
        break unless saved
      end
      
      return saved
    end
  end
    
end