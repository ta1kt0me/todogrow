module TasksHelper
  def panel_class_status(task)
    return 'panel-info' unless task.deadline

    sa = task.deadline.to_time - Time.now

    case sa.to_f / 3600
    when 72..Float::INFINITY then 'panel-primary'
    when 24..72 then 'panel-warning'
    else 'panel-danger'
    end
  end
end
