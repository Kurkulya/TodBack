json.data do
  json.lists @lists do |list|
    json.merge! list.attributes
    json.tasks list.tasks
  end
end