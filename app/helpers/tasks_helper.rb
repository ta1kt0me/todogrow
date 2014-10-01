module TasksHelper
  def panel_class_status(task)
    if task.deadline
      sa = task.deadline.to_date - Date.today
      case sa.to_f
        when 4..Float::INFINITY then 'panel-primary'
        when 1..3 then 'panel-warning'
        else 'panel-danger'
      end
    else
      'panel-info'
    end
  end
end
