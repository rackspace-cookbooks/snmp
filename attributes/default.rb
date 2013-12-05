#
# Cookbook Name:: snmp
# Attributes:: default
#
# Copyright 2010, Eric G. Wolfe
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

case node['platform_family']
  when "rhel"
    default['snmp']['packages'] = ["net-snmp", "net-snmp-utils"]
  when "debian"
    default['snmp']['packages'] = ["snmp", "snmpd"]
  when "suse"
    default['snmp']['packages'] = ["net-snmp"]
  else
    default['snmp']['packages'] = ["net-snmp", "net-snmp-utils"]
end

# Same on supported platforms:
# redhat, centos, fedora, scientific, debian, ubuntu
default['snmp']['service'] = "snmpd"

default['snmp']['community'] = "public"
default['snmp']['syslocationVirtual'] = "Virtual Server"
default['snmp']['syslocationPhysical'] = "Server Room"
default['snmp']['syscontact'] = "Root <root@localhost>"
default['snmp']['full_systemview'] = false
default['snmp']['trapcommunity'] = "public"
default['snmp']['trapsinks'] = Array.new
default['snmp']['is_dnsserver'] = false

# Debian default file options
default['snmp']['snmpd']['mibdirs'] = "/usr/share/snmp/mibs"
default['snmp']['snmpd']['mibs'] = nil
default['snmp']['snmpd']['snmpd_run'] = "yes"
default['snmp']['snmpd']['snmpd_opts'] = "-Lsd -Lf /dev/null -u snmp -g snmp -I -smux -p /var/run/snmpd.pid"
default['snmp']['snmpd']['trapd_run'] = "no"
default['snmp']['snmpd']['trapd_opts'] = "-Lsd -p /var/run/snmptrapd.pid"
default['snmp']['snmpd']['snmpd_compat'] = "yes"
