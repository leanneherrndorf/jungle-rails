require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is saved successfully" do
       user = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'test@test.com',
        password: 'testpassword',
        password_confirmation: 'testpassword'
        )
      expect(user).to be_persisted
    end

    it "password and password confirmation fields must be equal" do
      user = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'test@test.com',
        password: 'testpassword',
        password_confirmation: 'testpassword1'
        )
      expect(user.password).not_to eq(user.password_confirmation)
    end

    it "must be a unique email" do
      user = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'test@test.com',
        password: 'testpassword',
        password_confirmation: 'testpassword'
      )
      user1 = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'TEST@TEST.COM',
        password: 'testpassword',
        password_confirmation: 'testpassword'
      )
      expect(user1).to_not be_persisted
    end

    it "password should have a minimum length of 5" do
      user = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'test@test.com',
        password: 'asdf',
        password_confirmation: 'asdf'
      )
      expect(user).to_not be_persisted
    end
  end

  describe '.authenticate_with_credentials' do
    it "method should successfully authenticate with credentials" do
      user2 = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'test@test.com',
        password: 'testpassword',
        password_confirmation: 'testpassword'
      )
      result = User.authenticate_with_credentials(user2[:email], "testpassword")
      expect(result.id).to eql(user2.id)
    end

    it "should not authenticate with incorrect email" do
       user3 = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'test@test.com',
        password: 'testpassword',
        password_confirmation: 'testpassword'
      )
      result = User.authenticate_with_credentials("example@example.com", "testpassword")
      expect(result).to be nil
    end

    it "should not authenticate with incorrect password" do
       user4 = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'test@test.com',
        password: 'testpassword',
        password_confirmation: 'testpassword'
      )
      result = User.authenticate_with_credentials(user4[:email], "testpassword1")
      expect(result).to be nil
    end

    it "should authenticate even with spaces around the email" do
      user5 = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'test1@test.com',
        password: 'testpassword',
        password_confirmation: 'testpassword'
      )
      result = User.authenticate_with_credentials(" test1@test.com ", "testpassword")
      expect(result.id).to eql(user5.id)
    end

    it "should authenticate with wrong case typed email" do
       user6 = User.create(
        firstname: 'test',
        lastname: 'test',
        email: 'test2@test.com',
        password: 'testpassword',
        password_confirmation: 'testpassword'
      )
      result = User.authenticate_with_credentials(" tESt2@test.com ", "testpassword")
      expect(result.id).to eql(user6.id)
    end

  end
end
