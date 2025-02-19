module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :notice  then "alert-success"
    when :alert   then "alert-danger"
    when :error   then "alert-danger"
    when :warning then "alert-warning"
    when :info    then "alert-info"
    else "alert-primary"
    end
  end
end
