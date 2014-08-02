module ApplicationHelper

  def signin_out_link
    if SessionUser.signed_in?(session)
      content_tag :li do
        link_to 'Sign out', user_path, method: :delete
      end
    end
  end

end
