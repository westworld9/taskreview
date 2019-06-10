module ApplicationHelper
    def avatar_image(name)
      image_tag InitialAvatar.avatar_data_uri(name.first), class: "avatar"
    end
end
