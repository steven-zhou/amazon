class AmazonSetting < ActiveRecord::Base
  

  def self.array_for_select
    sql = "SELECT distinct(type) FROM amazon_settings"
    db_data = ActiveRecord::Base.connection.execute(sql)

    results = Array.new

    for row in db_data do
      results << [ ["#{row['type']}"], ["#{row['type']}"] ]
    end

    return results
  end

end
