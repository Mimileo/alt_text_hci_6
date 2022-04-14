class Flag < ApplicationRecord
    has_one :alt
    has_one :user
end
