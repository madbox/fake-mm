namespace :roles do
  desc "Enshure proper roles"
  task :ensure => [ :environment ] do
    require 'declarative_authorization/maintenance'
    include Authorization::TestHelper

    without_access_control do
      roles = [ 'newsmaker', 'author', 'customer', 'admin' ]
      ( roles - Role.all.map(&:sysname) ).each do |r|
        Role.create( :sysname => r )
      end
    end
  end

end
