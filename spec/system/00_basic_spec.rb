require 'spec_helper_system'

describe "basic tests:" do  
  describe file('/tmp/setupblock') do
    it { should be_file }
    it { should contain 'foobar' }
  end

  describe user('root') do
    it { should exist }
    it { should have_uid 0 }
  end

  if rspec_system_nodes.size > 1
    it_should_behave_like "multinode tests", rspec_system_nodes
  end
end
