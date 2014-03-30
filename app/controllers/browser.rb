require 'yajl'
class BrowserController < Sinatra::Base

  helpers ZkHelper

  get "/" do
    content_type :json, charset:'utf-8'
    path = params[:path]
    children = ZkHelper.get_children(path)
    nodes = []
    children.each do | child |
      node = {}
      node[:path] = child
      node[:children] = true
      node[:parent] = path
      node[:id] = "#{path}/#{child}"
      nodes << node
    end
    Yajl::Encoder.encode(nodes)
  end

  get "/data" do
    path = params[:path]
    ZkHelper.get_data(path)
  end

  get "/stat" do
    content_type :json, charset:'utf-8'
    path = params[:path]
    stat = ZkHelper.get_stat(path)
    hash = {}
    hash[:czxid] = stat.czxid
    hash[:mzxid] = stat.mzxid
    hash[:ctime] = stat.ctime
    hash[:mtime] = stat.mtime
    hash[:version] = stat.version
    hash[:cversion] = stat.cversion
    hash[:aversion] = stat.aversion
    hash[:ephemeralOwner] = stat.ephemeralOwner
    hash[:dataLength] = stat.dataLength
    hash[:numChildren] = stat.numChildren
    Yajl::Encoder.encode(hash)
  end
end
