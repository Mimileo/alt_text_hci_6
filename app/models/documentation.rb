class Documentation < ApplicationRecord
	has_rich_text :body
	has_rich_text :seo
	has_rich_text :description
end
