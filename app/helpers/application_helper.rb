module ApplicationHelper
  def nav_link_to(name:, path:, html_options: {})
    active_class = current_page?(path) ? "active" : ""
    classes      = [ html_options[:class], active_class ].compact.join(" ")

    link_to(name, path, html_options.merge(class: classes))
  end

  def bs_form_field(form:, field:, label:, as:, icon: nil, icon_position: :left, value: nil)
    label_tag = form.label(field, label, class: "form-label")

    errors = if object = form.object
      object.errors[field]
    else
      []
    end
    invalid_class = errors.any? ? "is-invalid" : ""

    input_options = { class: "form-control #{invalid_class}" }
    input_options[:value] = value if value.present?

    input_field = form.send(as, field, input_options)

    error_feedback = if errors.any?
                      content_tag(:ul, class: "invalid-feedback mb-0") do
                        errors.map { |msg| concat(content_tag(:li, msg)) }
                      end
    else
                      "".html_safe
    end

    unless icon
      return content_tag(:div) do
        label_tag + input_field + error_feedback
      end
    end

    icon_html = content_tag(:span, icon, class: "input-group-text")

    input_group = content_tag(:div, class: "input-group") do
      if icon_position == :left
        icon_html + input_field + error_feedback
      else
        input_field + icon_html + error_feedback
      end
    end

    content_tag(:div) do
      label_tag + input_group
    end
  end
end
