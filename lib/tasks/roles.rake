namespace :roles do
  desc "Enshure proper roles"
  task :ensure_roles => [ :environment ] do
    roles = [ 'newsmaker', 'author', 'customer', 'admin' ]
    ( roles - Role.all.map(&:sysname) ).each do |r|
      Role.create( :sysname => r )
    end
  end
end
