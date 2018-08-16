require 'redmine'
require 'redmine_prj_treeview'

Redmine::Plugin.register :redmine_prj_treeview do
  name 'Redmine Prj Treeview plugin'
  author 'Bernardes'  
  author_url 'https://github.com/patajones'
  description 'Redmine plugin to show up the projects as a tree'
  version '1.1.0'
  requires_redmine :version_or_higher => '3.1.0'
end

Rails.configuration.to_prepare do 

end
