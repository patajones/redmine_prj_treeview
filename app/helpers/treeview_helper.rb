module TreeviewHelper

	def render_project_treeview(scope)
		@scope = scope
		s = ""
		s << stylesheet_link_tag("responsive.css", :plugin => "redmine_prj_treeview")
		s << stylesheet_link_tag("bootstrap.table.css", :plugin => "redmine_prj_treeview")
		s << stylesheet_link_tag("jquery.treegrid.css", :plugin => "redmine_prj_treeview")
		s << stylesheet_link_tag("prjtreeview.css", :plugin => "redmine_prj_treeview")
		s << javascript_include_tag("jquery.treegrid.min.js", :plugin => "redmine_prj_treeview")
		s << javascript_include_tag("jquery.treegrid.js", :plugin => "redmine_prj_treeview")
		s << javascript_include_tag("jquery.cookie.js", :plugin => "redmine_prj_treeview")
			
		index = 0
		s_linhas = ""
		parent_classes = []
		@scope.order(:lft).each do |project|
			index += 1
			parent_classes.pop while (parent_classes.length > 0) && parent_classes.last[0] != project.parent_id
			parent_class = parent_classes.length > 0 ? parent_classes.last[1] : ""
			s_linhas << content_tag('tr', inner_row_project(project), :class => "treegrid-#{index} #{parent_class}", :id => "project_id_#{project.id}")
			parent_classes.push([project.id, "treegrid-parent-#{index}"])
		end		
		
		s << content_tag("table", s_linhas.html_safe, {:class => "table table-condensed table-tree"})				
		s << content_tag("script", "$('.table-tree').treegrid({initialState: 'collapsed', treeColumn: 0, saveState: true});".html_safe)				
		s.html_safe
	end
	
	private
	
	def inner_row_project(project)
		content = content_tag('td', link_to_project(project, {}, :class => "#{project.css_classes} #{User.current.member_of?(project) ? 'icon icon-fav my-project' : nil}"))				
		description = project.description.present? ? textilizable(project.short_description, :project => project) : ""
		s_coluna_wiki = content_tag('div', description, :style => "max-width: 500px;")
		content << content_tag('td', s_coluna_wiki, :class => "wiki description")
		content.html_safe
	end
			
			
end
