json.extract! coin, :id, :description, :acronym, :string, :url_image, :created_at, :updated_at
json.url coin_url(coin, format: :json)
