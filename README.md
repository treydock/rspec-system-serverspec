# rspec-system-serverspec

`rspec-system-serverspec` is a [Serverspec](http://serverspec.org/) plugin for [rspec-system](https://rubygems.org/gems/rspec-system). The purpose is to provide the ability to use Serverspec matchers in rspec-system tests.

## Quick Start

* Have a module that is configured to use rspec-system
* `gem install serverspec`
* Add the `serverspec` and `rspec-system-serverspec` gems to your module's `Gemfile`
* Add these lines to your `spec/spec_helper_system.rb` file:

```ruby
require 'rspec-system-serverspec/helpers'
include Serverspec::Helper::RSpecSystem
include Serverspec::Helper::DetectOS
```

## Multi-node tests

If you wish to perform rspec tests on multiple nodes, you can speficiy the node using the **node** metadata parameter.

Using the **node** example metadata

```ruby
describe host('server.vm'), :node => 'client.vm'  do
  it { should be_resolvable }
end

describe host('client.vm'), :node => 'server.vm'  do
  it { should be_resolvable }
end
```
