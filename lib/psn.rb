require "psn/version"
require "psn/user"
require "psn/api"
require "psn/games_list"
require "psn/game"

module PSN
  def self.api
    @@api ||= PSN::API.new
  end
end
