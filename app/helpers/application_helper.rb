module ApplicationHelper
  def flash_class(type)
    case type.to_sym
    when :notice
      "bg-green-100 text-green-800"
    when :alert
      "bg-red-100 text-red-800"
    else
      "bg-gray-100 text-gray-800"
    end
  end
end
