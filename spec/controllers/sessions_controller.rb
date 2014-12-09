describe 'POST #create' do
  context 'when password is invalid' do
    it 'renders the page with error' do
      user = create(:user, email: "sup@mail.com", password: "12345656", username: "thomas")
      post :create, session: { email: user.email, password: 'invalid', username: user.username }
    end
  end

  context 'when password is valid' do
    it 'sets the user in the session and redirects them to their dashboard' do
      user = create(:user, email: "sup@mail.com", password: "12345656", username: "thomas")

      post :create, session: { email: user.email, password: user.password, username: user.username }

      expect(controller.current_user).to eq user
    end
  end
end