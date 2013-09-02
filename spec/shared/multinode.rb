shared_examples "multinode tests" do |nodes|
  nodes.each do |node|
    describe file('/tmp/setupblock'), :node => node do
      it { should be_file }
      it { should contain 'foobar' }
    end

    describe user('root'), :node => node  do
      it { should exist }
      it { should have_uid 0 }
    end
  
    describe file('/tmp/nodename'), :node => node  do
      it { should contain example.metadata[:node] }
    end
  end
end
