json.extract! task_list, :id, :title, :description, :status, :deleted_at, :created_at, :updated_at
json.url task_list_url(task_list, format: :json)
