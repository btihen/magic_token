json.extract! user, :id, :email, :token, :token_expires_at, :created_at, :updated_at
json.url user_url(user, format: :json)
