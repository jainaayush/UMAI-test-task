require 'pry'
require 'spec_helper'
require './post.rb'

RSpec.describe User do
  it "Insert user" do
    user = User.insert_user('demo')
    post = Post.insert_post('demo title', 'demo test', '127.0.0.1', user["id"].to_i)
    expect(post.first["title"]).to eql('demo title')
    expect(post.first["content"]).to eql('demo test')
    expect(post.first["user_id"]).to eql(user["id"])
  end
end