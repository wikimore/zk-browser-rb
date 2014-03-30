class IndexController < Sinatra::Base

  root = File.join(File.dirname(__FILE__), '../..')
  puts root
  set :root, root
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }
  puts File.join(root, "public")
  set :public_folder, Proc.new { File.join(root, "public") }
  set :static, true

  get "/" do
    root_path = ["root","hbase","reminder"]
    erb :index
  end

end