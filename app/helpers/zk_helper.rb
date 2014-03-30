require 'zookeeper'

module ZkHelper
  def self.get_children(path)
    if path == nil
      path = "/"
    end
    children = $zk.get_children(:path => path)[:children]
  end

  def self.get_data(path)
    $zk.get(:path => path)[:data]
  end

  def self.get_stat(path)
    stat = $zk.stat(:path => path)[:stat]
  end
end
