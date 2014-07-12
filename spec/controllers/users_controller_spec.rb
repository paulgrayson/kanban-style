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
    context 'valid credentials' do
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

    context 'invalid credentials' do
      before { @pivotal_stub.stub(fetch_token: false) } 

      it 'renders the same template' do
        post :create, user: { email: email, password: password }
        expect(response).to redirect_to(root_path)
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

