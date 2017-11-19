json.extract! topic, :id, :title, :date, :user_id, :created_at, :updated_at
json.url api_topic_url(topic, format: :json)
