wanted = task.attributes.keys.map(&:to_sym) - [:created_at, :updated_at] 
json.extract! task, *wanted 
json.feature task.feature
json.tags task.tags
json.status task.status