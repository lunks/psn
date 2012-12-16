require 'spec_helper'
require 'psn/api'

module PSN
  describe API do
    let(:api) { API.new }
    let(:user) { User.new("RazrPSN") }

    it "fetches player summaries for an user", :vcr do
      api.player_summaries_for(user).should be_a_kind_of Nokogiri::XML::Document
    end

    it "fetches games for an user", :vcr do
      api.games_for(user).should be_a_kind_of Nokogiri::XML::NodeSet
    end
  end
end
