module PSN
  class GamesList
    def initialize(user)
      @user = user
    end

    def games
      games = parse_games(fetch_games)
    end

    private
    def fetch_games
      API.new.games_for(@user)
    end

    def parse_games(xml_nodes)
      @games ||= xml_nodes.select{|xml| xml.search("Id").text.present?}.map{|xml| Game.new xml}
    end
  end
end
