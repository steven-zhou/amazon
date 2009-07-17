module PhonesHelper
  def preferrence_time_options
    options = []
    options << ["No Contact",0]
    options << ["Business Hour",1]
    options << ["After Hours",2]
    options << ["Any Time",3]
    return options
  end
end
