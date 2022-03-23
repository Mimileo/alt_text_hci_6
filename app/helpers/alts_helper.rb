module AltsHelper
	def linked_tag_list(alt)
		list = alt.tag_list.map do |tag_name|
      		link_to tag_name, root_path(tag: tag_name)
    	end
    	safe_join list, ", "
	end

	def alt_user(alt)
		user = alt.user
	end

	def first_last_name(alt)
		if alt.user.first_name && alt.user.last_name.present?
			fl_name = alt.user.first_name + " " + alt.user.last_name
		else
			"[First Name] [Last Name]"
		end
	end

	def verification(alt)
		if alt.verified == false
      if super_admin || referee
        	link_to "Verify", edit_alt_path, class: "btn btn-sm btn-outline-primary"
      else
        "Modifiable"
      end
    else
      "Verified by Seven Army"
    end
	end

	

end
