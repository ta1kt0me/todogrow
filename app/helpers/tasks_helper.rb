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

  def create_google_calendar_link(task)
    "http://www.google.com/calendar/event?action=TEMPLATE&text=#{URI.escape(task.name)}&trp=false&sprop=name:TodoGrow"
    # &details='説明'
    # &location='場所'
    # &dates='20141007/20141008(この場合終日になる)'
    # &sprop=website:'リンク設置元のURL'
  end
end
