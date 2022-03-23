json.extract! moderator, :id, :user_id, :title, :description, :super_admin, :moderator, :contributor, :flag, :created_at, :updated_at
json.url moderator_url(moderator, format: :json)
