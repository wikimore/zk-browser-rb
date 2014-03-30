require 'sinatra'
require 'sinatra/base'

require 'zookeeper'

$zk = Zookeeper.new("tracker.test.lan:2181")

requires = Dir[]
['app/helpers','app/controllers','app/models'].each do |path|
  requires += Dir[File.expand_path("#{path}/*.rb", __dir__)]
end

requires.each do |file|
  require file
end

Dir.glob(File.expand_path("../app/controllers", __FILE__) + '/**/*.rb').each do |file|
  controller_file = File.basename(file, ".rb")
  mapper = controller_file
  controller_class_name = "#{controller_file.capitalize}Controller"
  controller_class = eval(controller_class_name)
  if mapper == "index"
    puts "map: / for class: #{controller_class}"
    map("/") {
      run controller_class
    }
  else
    puts "map: /#{mapper} for class: #{controller_class}"
    map("/#{mapper}") {
      run controller_class
    }
  end
end

#run Sinatra::Application
