require 'redmine'
require 'redmine_prj_treeview'

Redmine::Plugin.register :redmine_prj_treeview do
  name 'Redmine Prj Treeview plugin'
  description 'Redmine plugin to show up the projects as a tree'
  version '0.0.1'
  requires_redmine :version_or_higher => '3.1.0'
end

Rails.configuration.to_prepare do 

end
