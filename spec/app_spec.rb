require_relative 'spec_helper.rb'

describe 'LinkHandler Application' do
  describe 'Short link generation' do
    it 'should generate short link with valid params' do
      post '/', { longUrl: 'fooBar' }
      assert last_response.ok?
      expect(last_response.body[:url].nil?).to be_falsey
    end

    it 'should return error with invalid params' do
      post '/'
      assert last_response.ok?
      expect(last_response.body[:error].nil?).to be_falsey
    end
  end

  describe 'Redirect through short link' do

    before(:all) do
      App.place_test_data
    end

    it 'should redirect' do
      req = get '/foo'
      expect(req).to redirect_to('bar')
    end

    it 'should return error message when long link not found' do
      get '/some'
      expect(last_response.body).to eq('Unknown short link some')
    end
  end
end
