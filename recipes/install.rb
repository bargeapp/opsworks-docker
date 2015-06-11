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
  `getent passwd deploy > /dev/null`
  if $?.success?
    execute "add #{deploy[:user]} to docker group" do
      command "usermod -aG docker #{deploy[:user]}"
      user 'root'
      action :run
    end
  end
end

service "docker" do
  action :start
end