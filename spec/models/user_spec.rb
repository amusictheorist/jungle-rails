require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with a name, email, password, and password_confirmation' do
      user = User.new(
        name: 'Test User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(name: nil, email: 'test@test.com', password: 'password', password_confirmation: 'password')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'is invalid without an email' do
      user = User.new(name: 'Test User', email: nil, password: 'password', password_confirmation: 'password')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is invalid with a duplicate email (case insensitive)' do
      user = User.create!(name: 'Test User', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      duplicate_user = User.new(name: 'Test User', email: 'TEST@TEST.COM', password: 'password', password_confirmation: 'password')
      expect(duplicate_user).to_not be_valid
      expect(duplicate_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'is invalid with a password shorter than 6 characters' do
      user = User.new(name: 'Test User', email: 'test@test.com', password: '123', password_confirmation: '123')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates user with correct credentials' do
      user = User.create!(
        name: 'Test User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'returns nil with incorrect password' do
      user = User.create!(
        name: 'Test User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil with incorrect email' do
      user = User.create!(
        name: 'Test User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('wrongemail@test.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates user with spaces around the email' do
      user = User.create!(
        name: 'Test User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('   test@test.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates user with case insensitive email' do
      user = User.create!(
        name: 'Test User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('TEST@TEST.COM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
