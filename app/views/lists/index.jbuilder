json.lists @lists do |list|
    json.merge! list.attributes
    json.tasks list.tasks.order_tasks
end