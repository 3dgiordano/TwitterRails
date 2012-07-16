require 'twitter_api'
require 'twit'

class Trend < ActiveRecord::Base
  
  attr_accessible :id, :name, :query, :as_of

  has_and_belongs_to_many :twit

  def self.refresh_trends_from_api(woeid=1)
    trends_api = TwitterAPI.get_trends(woeid)
    return if trends_api.include?("errors")
    trends_api.each{|e| e["trends"].each{|t| Trend.create(:name => t["name"], :query => t["query"], :as_of  => e["as_of"]) }}
  end

  def refresh_twits_from_api
    twits_api = TwitterAPI.get_twits_for_trend(query)
    return if twits_api.include?("errors")
    twits_api["results"].each{|t|  self.twit.find_by_id(t["id"]) || self.twit << Twit.find_or_create_by_id(t["id"]) }
  end

end
