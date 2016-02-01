module ContentManager
  class ContentsIndexContent < ContentBase
    content_key :keys_title, default: "Content Keys"
    content_key :versions_title, default: "Content Versions"
    content_key :destroy_button, default: "Destroy"
    content_key :edit_button, default: "Edit"
    content_key :new_button, default: "New"
  end
end
