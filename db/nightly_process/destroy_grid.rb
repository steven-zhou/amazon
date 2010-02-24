puts "destroy grid ..."
Grid.all.each do |i|
  i.destroy
end