require 'pry'
require 'spec_helper'
require './user.rb'

RSpec.describe User do
  it "Insert user" do
    user = User.insert_user('demo')
    expect(user["username"]).to eql('demo')
  end
end
