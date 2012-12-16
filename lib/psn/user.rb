module PSN
  class User
    attr_accessor :id
    def initialize(id)
      @id = id
    end

    def games
      @games ||= GamesList.new(self).games
    end

    def avatar
      @avatar ||= profile_info.search('Avatar').text
    end

    private
    def profile_info
      @profile_info ||= PSN::api.player_summaries_for(self)
    end


  end
end
