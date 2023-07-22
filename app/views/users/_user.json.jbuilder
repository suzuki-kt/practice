json.extract! user, :id, :name, :email, :password, :image_name, :profile, :created_at, :updated_at
json.url user_url(user, format: :json)
