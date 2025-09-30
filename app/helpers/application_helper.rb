module ApplicationHelper
  def nav_link_to(name:, path:, html_options: {})
    active_class = current_page?(path) ? "active" : ""
    classes      = [ html_options[:class], active_class ].compact.join(" ")

    link_to(name, path, html_options.merge(class: classes))
  end
end
