module ApplicationHelper
  def sortable(column, title= nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc" ? "desc" : "asc")
    link_to title, sort: column, direction: direction
  end

  def current_order
    if Order.find_by_id(session[:order_id]).nil?
      Order.new
    else
      Order.find_by_id(session[:order_id])
    end
  end
end
