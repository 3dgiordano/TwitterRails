require 'twitter_api'

class User < ActiveRecord::Base
  attr_accessible :id

  before_create :new_from_api

  def new_from_api
    user_response = TwitterAPI.get_user_information_by_id(self.id)
    self.screen_name = user_response["screen_name"]
    self.name = user_response["name"]
    self.followers_count = user_response["followers_count"]
  end

  def profile_image(size = "normal")
    TwitterAPI.get_user_profile_image(self.screen_name, size)
  end

end
