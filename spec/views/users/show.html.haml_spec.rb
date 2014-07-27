require 'rails_helper.rb'

describe 'users/show.html.haml' do

  let(:user) { User.new }
  before { assign(:user, user) }

  context 'new user' do
    it 'renders form with fields' do
      render
      rendered.should have_selector('form')
      rendered.should have_selector('#user_email_field')
      rendered.should have_selector('#user_password_field')
    end
  end

  context 'user with errors' do
    it 'renders errors' do
      error_message = 'error message'
      user.errors.add(:email, error_message)
      user.errors.add(:password, error_message)
      render
      rendered.should have_selector('#user_email_field .help-block', text: error_message)
      rendered.should have_selector('#user_password_field .help-block', text: error_message)
    end
  end

end

