require "rails_helper"

RSpec.describe User, type: :model do
  describe "#full_name" do
    it "joins first and last name together with a space" do
      user = FactoryBot.build(:user, first_name: "Jane", last_name: "Doe")
      expect(user.full_name).to eq("Jane Doe")
    end
    it "trims dangling spaces at the beginning and the end" do
      user = FactoryBot.build(:user, first_name: "Jane   ", last_name: nil)
      expect(user.full_name).to eq("Jane")
      user = FactoryBot.build(:user, first_name: nil, last_name: "        Doe    ")
      expect(user.full_name).to eq("Doe")
    end
  end

  describe "#capitalize_name" do
    it "capitalizes each word in full_name" do
      persisted_user = FactoryBot.create(:user, first_name: "jane", last_name: "doe")
      expect(persisted_user.full_name).to eq("Jane Doe")
    end
  end

  describe "validates" do
    it "requires unique emails" do
      persisted_user = FactoryBot.create(:user)
      user = FactoryBot.build(:user, email: persisted_user.email)
      user.valid?
      expect(user.errors.messages).to have_key(:email)
    end
    ["what", "$()@something.com", "bob@google.89", "test@test#com", "@end.ca", "ð¥ð¦ð¥@bob.ca" ].each do |invalid_email|
      it "requires email: #{invalid_email} to be invalid" do
        user = FactoryBot.build(:user)
        user.email = invalid_email
        user.valid?
        expect(user.errors.messages).to have_key(:email)
      end
    end
  end
end
