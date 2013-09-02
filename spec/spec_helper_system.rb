require 'rspec-system/spec_helper'
require 'rspec-system-serverspec/helpers'

dir = File.expand_path(File.dirname(__FILE__))
Dir["#{dir}/shared/*.rb"].sort.each {|f| require f}

module LocalHelpers
  include RSpecSystem::InternalHelpers

  def proj_root
    Pathname.new(File.join(File.dirname(__FILE__), '..'))
  end

  def rspec_system_nodes
    rspec_system_node_set.nodes.collect { |k,v| k }
  end
end

include LocalHelpers
include Serverspec::Helper::RSpecSystem
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.include LocalHelpers

  c.before :suite do
    rspec_system_nodes.each { |n| shell :command => 'echo foobar > /tmp/setupblock', :node => n }
    rspec_system_nodes.each { |n| shell :command => "echo #{n} > /tmp/nodename", :node => n }
  end
end
