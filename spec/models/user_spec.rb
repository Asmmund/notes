require 'spec_helper'

describe User do
  it { should have_many(:articles) }
  it { should validate_presence_of(:name)}
  it 'should validate uniqueness of name' do
    user_invalid
    should validate_uniqueness_of(:name)
  end
  it { should validate_presence_of(:email)}
  it 'Should validate uniqueness of email' do
   user_invalid
   should validate_uniqueness_of(:email)
  end
  def user_invalid
      User.new(password:'whatever', name: 'sdf',email:'something@s.com').save!(:validate => false)
  end
end
