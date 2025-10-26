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
    icon          = options.delete(:icon)
    icon_position = options.delete(:icon_position) || :left
    wrapper_class = options.delete(:wrapper_class)

    collection     = options.delete(:collection)
    select_options = options.delete(:select_options) || {}

    step = options.delete(:step)

    label_tag = form.label(field, label, class: "form-label")

    errors = form.object ? form.object.errors[field] : []
    invalid_class = errors.any? ? "is-invalid" : ""

    html_options = options.dup
    html_options[:class] = "#{options[:class]} #{invalid_class}".strip
    html_options[:step] = step if !step.nil?

    input_field = if as == :select
      html_options[:class] = "form-select #{html_options[:class]}".strip
      form.select(field, collection, select_options, html_options)
    else
      html_options[:class] = "form-control #{html_options[:class]}".strip
      form.send(as, field, html_options)
    end

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

    input_group = content_tag(:div, class: "input-group has-validation") do
      if icon_position == :left
        icon_html + input_field
      else
        input_field + icon_html
      end
    end

    content_tag(:div, class: wrapper_class) do
      label_tag + input_group + error_feedback
    end
  end
end
