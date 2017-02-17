module TreeviewHelper

	def render_project_treeview(scope)						    
		@scope = scope
		s = ""
		s << stylesheet_link_tag("responsive.css", :plugin => "redmine_prj_treeview")
		s << stylesheet_link_tag("bootstrap.table.css", :plugin => "redmine_prj_treeview")
		s << stylesheet_link_tag("jquery.treegrid.css", :plugin => "redmine_prj_treeview")
		s << javascript_include_tag("jquery.treegrid.min.js", :plugin => "redmine_prj_treeview")
		s << javascript_include_tag("jquery.treegrid.js", :plugin => "redmine_prj_treeview")
		s << javascript_include_tag("jquery.cookie.js", :plugin => "redmine_prj_treeview")
		
		s_linhas = ""
		@i = 0
		def render_row project, parent_class = ""
		    i = @i
			s_coluna_nome = content_tag('td', link_to_project(project, {}, :class => "#{project.css_classes} #{User.current.member_of?(project) ? 'my-project' : nil}"))				
			description = project.description.present? ? textilizable(project.short_description, :project => project) : ""
			s_coluna_wiki = content_tag('div', description, :style => "max-width: 500px;")
			s_coluna_wiki = content_tag('td', s_coluna_wiki, :class => 'wiki description')										
			s = content_tag('tr', s_coluna_nome+s_coluna_wiki, :class => "treegrid-#{i} #{parent_class}")
			@scope.where(parent_id: project.id).each do |child|
			    @i += 1
				s << render_row(child, "treegrid-parent-#{i}")
			end
			s
		end
		@scope.where(parent_id: nil).each do |project|
		    @i += 1
			s_linhas << render_row(project)
		end
		s << content_tag("table", s_linhas.html_safe, {:class => "table table-condensed table-tree"})				
		s << content_tag("script", "$('.table-tree').treegrid({initialState: 'collapsed', treeColumn: 0, saveState: true});".html_safe)				
		s.html_safe
	end	
			
			
end
