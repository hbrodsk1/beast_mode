require 'rails_helper'

RSpec.feature "user sign up", type: :feature do
	scenario 'with valid credentials' do
		@user = FactoryGirl.attributes_for(:user)

		visit 'users/sign_up'
		fill_in('Email', with: @user[:email])
		fill_in('Username', with: @user[:username])
		fill_in('Password', with: @user[:password])

		click_button('sign-up-button')

		expect(page).to have_current_path(users_path)
	end

	scenario 'with invalid credentials' do
		@invalid_user = FactoryGirl.attributes_for(:invalid_user)

		visit 'users/sign_up'
		fill_in('Email', with: @invalid_user[:email])
		fill_in('Username', with: @invalid_user[:username])
		fill_in('Password', with: @invalid_user[:password])
		fill_in('user_password_confirmation', with: @invalid_user[:password])

		click_button('sign-up-button')

		expect(page).to have_current_path(users_path)
		expect(page).to have_selector(:link_or_button, 'sign-up-button')
	end
end