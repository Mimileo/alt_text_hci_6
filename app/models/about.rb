class About < ApplicationRecord
	has_rich_text :body
	has_rich_text :description
	has_rich_text :seo
end
