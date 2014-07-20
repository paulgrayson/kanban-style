require 'rails_helper'

describe UsersController do

  # ensure no method on any PivotalClient instance is called
  before do
    @pivotal_stub = double
    subject.stub(:pivotal).and_return(@pivotal_stub)
  end

  let(:email) { double }
  let(:password) { double }

  describe '#create' do

    context 'no credentials' do
      it 'renders the show template' do
        post :create, user: {email: '', password: ''}
        expect(response).to render_template(:show)
      end
    end

    context 'valid pivotal credentials' do
      let(:api_token) { double }
      before { @pivotal_stub.stub(fetch_token: api_token) } 

      it 'redirects to projects path' do
        post :create, user: { email: email, password: password }
        expect(response).to redirect_to(projects_path)
      end

      it 'sets a pivotal cookie with the api token' do
        post :create, user: { email: email, password: password }
        session[:api_token].should == api_token
      end
    end

    context 'invalid pivotal credentials' do
      before { @pivotal_stub.stub(fetch_token: false) } 

      it 'renders the same template with flash' do
        post :create, user: { email: email, password: password }
        expect(response).to render_template(:show)
        expect(flash.now[:error]).to eq 'Invalid credentials'
      end
    end
  end

  describe '#destroy' do
    it 'deletes the pivotal cookie' do
      session[:api_token] = double
      delete :destroy
      session[:api_token].should be_nil
    end
  end

end

