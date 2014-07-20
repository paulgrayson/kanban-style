module UsersHelper

  def field_with_errors(model, field_name, &block)
    has_error = model.errors[field_name].present?
    content_tag(:div, id: "user_#{field_name}_field", class: 'field') do
      concat content_tag(:div, @user.errors[:email].join(', '), class: 'error') if has_error
      concat capture(&block) if block_given?
    end
  end

end
