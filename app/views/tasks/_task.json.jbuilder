json.extract! task, :id, :content, :position, :created_at, :updated_at
json.url task_url(task, format: :json)
