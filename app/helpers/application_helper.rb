module ApplicationHelper
  def nav_link_to(name:, path:, html_options: {})
    request_path = request.fullpath
    base_path    = path.is_a?(String) ? path : url_for(path)

    active_class =
      if base_path == root_path
        request_path == root_path
      else
        request_path.start_with?(base_path)
      end

    classes = [ html_options[:class], (active_class ? "active" : nil) ].compact.join(" ")

    link_to(name, path, html_options.merge(class: classes))
  end

  def bs_form_field(form:, field:, label:, as:, **options)
    icon          = options[:icon]
    icon_position = options[:icon_position] || :left
    value         = options[:value]
    placeholder   = options[:placeholder]
    wrapper_class = options[:wrapper_class]

    label_tag = form.label(field, label, class: "form-label")

    errors = form.object ? form.object.errors[field] : []
    invalid_class = errors.any? ? "is-invalid" : ""

    input_options               = { class: "form-control #{invalid_class}" }
    input_options[:value]       = value if value.present?
    input_options[:placeholder] = placeholder if placeholder.present?

    input_field = form.send(as, field, input_options)

    error_feedback = if errors.any?
      content_tag(:ul, class: "invalid-feedback mb-0") do
        errors.map { |msg| concat(content_tag(:li, msg)) }
      end
    else
      "".html_safe
    end

    unless icon
      return content_tag(:div, class: wrapper_class) do
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

    content_tag(:div, class: wrapper_class) do
      label_tag + input_group
    end
  end
end
