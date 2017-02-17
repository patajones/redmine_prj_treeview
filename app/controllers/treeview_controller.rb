class TreeviewController < ApplicationController
  unloadable


  def projects	
	if params[:ids].nil?
		@project_tree = Project.where(:id => null)
	else
		@project_tree = Project.where(:id => params[:ids].split(","))
		logger.info "@project_tree.size: #{@project_tree.size}"
	end
	  
	respond_to do |format|
		format.js {  }
	end  
  end
end
