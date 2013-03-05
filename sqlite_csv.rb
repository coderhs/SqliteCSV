class SqliteCSV
  require 'sequel'
  require 'csv'
  @db
  @final_location
  def initialize(db,final_location)
    @db = Sequel.connect("sqlite://#{db}")
    @final_location = final_location
  end

  def export()
    @db[:sqlite_sequence].each do |test|
      file = CSV.open("#{@final_location}/#{test[:name]}.csv",'w')
      @db["#{test[:name]}".to_sym].each do |item|
        skip = true
        row = Array.new
        item.each do |dataset|
          if dataset[1].class == "String".class
            dataset[1]=dataset[1].gsub(',',' ')
          end
          row << dataset[1]
        end
        file << row
      end
      file.close
    end
  end
end