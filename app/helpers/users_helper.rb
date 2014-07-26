module UsersHelper

  def field_with_errors(model, field_name, css_classes='', &block)
    has_error = model.errors[field_name].present?
    content_tag(:div, id: "user_#{field_name}_field", class: "#{css_classes}#{has_error ? ' has-error' : ''}") do
      concat capture(&block) if block_given?
      concat content_tag(:span, @user.errors[field_name].join(', '), class: 'help-block') if has_error
    end
  end

end
