# frozen_string_literal: true

json.extract! user, :id, :wvu_username, :email, :last_name, :first_name, :middle_name, :created_at, :updated_at
json.url user_url(user, format: :json)
