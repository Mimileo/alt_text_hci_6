class AltFavorite < ApplicationRecord
	belongs_to :alt
	belongs_to :user
end
