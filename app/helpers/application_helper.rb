module ApplicationHelper
  def alert_close_icon
    haml_tag(:button, class: 'close', type: 'button', 'data-dismiss' => 'alert', 'aria-hidden' => 'true') do
      haml_concat '&times;'
    end
  end
end
