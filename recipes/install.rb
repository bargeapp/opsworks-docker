# taken straight from http://blogs.aws.amazon.com/application-management/post/Tx2FPK7NJS5AQC5/Running-Docker-on-AWS-OpsWorks

case node[:platform]
when "ubuntu","debian"
  package "docker.io" do
    action :install
  end
when 'centos','redhat','fedora','amazon'
  package "docker" do
    action :install
  end
end

node[:deploy].each do |application, deploy|
  user 'root'
  bash "usermod -aG docker #{deploy[:user]}"
end

service "docker" do
  action :start
end