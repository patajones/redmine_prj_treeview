module RedminePrjTreeview::Patches

	module ProjectsHelperPatch
		def self.included(base)
			base.extend(ClassMethods)			
			base.send(:include, InstanceMethods)
			
			base.class_eval do
				alias_method_chain :render_project_hierarchy, :treeview
				alias_method_chain :render_project_action_links, :treeview
			end
		end
		
		module ClassMethods
		
		end	
		
		module InstanceMethods	
			def render_project_hierarchy_with_treeview(projects)				
				href = "/treeview/projects?ids=#{projects.map{|p| p.id}.join(",")}"
				content_tag("script", "$(window).load(function() { $.ajax({type: 'GET', url: '#{href}', headers: {Accept: 'text/javascript'}}) });".html_safe)
			end
			
			def render_project_action_links_with_treeview
				links = []
				links << link_to(l(:expand_all), '#', :onclick => "$('.table-tree').treegrid('expandAll');".html_safe)
				links << link_to(l(:collapse_all), '#', :onclick => "$('.table-tree').treegrid('collapseAll');".html_safe)
				(render_project_action_links_without_treeview+" | "+links.join(" | ").html_safe)
			end			

		end
	end
	
end


unless ProjectsHelper.included_modules.include? RedminePrjTreeview::Patches::ProjectsHelperPatch
    ProjectsHelper.send(:include, RedminePrjTreeview::Patches::ProjectsHelperPatch)
end