module RelationshipsHelper
    def relationship_button(user)
        if user != @current_user
            relationship = @current_user.get_relationship(user)
            if relationship
                button_to "フォロー解除", relationship_path(relationship), method: :delete
            else
                button_to "フォローする", relationships_path(followee_id: user.id)
            end
        end
    end
end
