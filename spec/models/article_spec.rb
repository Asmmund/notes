require 'spec_helper'

describe Article do
  it { should validate_presence_of(:title)}
  it { should validate_uniqueness_of(:title)}
  it { should validate_presence_of(:body)}
end
