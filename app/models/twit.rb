require 'twitter_api'
require 'utils'

class Twit < ActiveRecord::Base

  has_and_belongs_to_many :trend

  belongs_to :user, :foreign_key=>"user_id", :readonly => :true

  attr_accessible :id

  before_create :new_from_api

  def new_from_api
    twit_response = TwitterAPI.get_twit_by_id(self.id)
    raise twit_response if twit_response.include?("errors")
    self.text = twit_response["text"]
    self.user_id = User.find_or_create_by_id(twit_response["user"]["id"]).id
    self.created_at = twit_response["created_at"]
  end

  def get_links
    Utils.get_links(self.text)
  end

end
