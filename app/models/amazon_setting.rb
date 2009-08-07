class AmazonSetting < ActiveRecord::Base
  

  def options_for_select
    sql = "SELECT distinct(type) FROM amazon_settings"
    db_data = ActiveRecord::Base.connection.execute(sql)
    results = ""
    for row in db_data do
      results += "<option value='" + "#{row[0]}" + "'>" + "#{row[0]}" + "</option>"
    end
    return results
  end
  
end
