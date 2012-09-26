#
# Cookbook Name:: nfs
# Test:: attributes_spec 
#
# Author:: Fletcher Nichol
# Author:: Eric G. Wolfe
#
# Copyright 2012, Fletcher Nichol
# Copyright 2012, Eric G. Wolfe
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require File.join(File.dirname(__FILE__), %w{.. support spec_helper})
require 'chef/node'
require 'chef/platform'

describe 'Snmp::Attributes::Default' do
  let(:attr_ns) { 'snmp' }

  before do
    @node = Chef::Node.new
    @node.consume_external_attrs(Mash.new(ohai_data), {})
    @node.from_file(File.join(File.dirname(__FILE__), %w{.. .. attributes default.rb}))
  end

  describe "for unknown platform" do
    let(:ohai_data) do
      { :platform_family => "unknown", :platform => "unknown", :platform_version => 3.14 }
    end

    it "sets the packages to net-snmp and net-snmp-utils" do
      @node[attr_ns]['packages'].sort.must_equal %w{ net-snmp net-snmp-utils }.sort
    end

    it "sets the snmp service to snmpd" do 
      @node[attr_ns]['service'].must_equal "snmpd"
    end
  end

  describe "platform_family rhel 6.2" do
    let(:ohai_data) do
      { "platform_family" => "rhel", :platform => "centos", :platform_version => 6.2 }
    end

    it "sets a package list to net-snmp and net-snmp-utils" do
      @node[attr_ns]['packages'].sort.must_equal %w{ net-snmp net-snmp-utils }.sort
    end
  end

  describe "for debian family (ubuntu) 10.04 platform" do
    let(:ohai_data) do
      { :platform_family => "debian", :platform => "ubuntu", :platform_version => 10.04 }
    end

    it "sets a package list to snmp and snmpd" do
      @node[attr_ns]['packages'].sort.must_equal %w{ snmp snmpd }.sort
    end
  end
end
