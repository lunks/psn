require 'active_support/all'
require 'retriable/no_kernel'
require 'open-uri'
require 'net/http'
require 'nokogiri'
module PSN
  class API
    BASE_URL="http://www.psnapi.com.ar/ps3/api/psn.asmx"
    attr_reader :client

    def player_summaries_for(user)
      fetch('getPSNID', "sPSNID" => user.id.to_s)
    end

    def games_for(user)
      document = fetch('getGames', "sPSNID" => user.id.to_s)
      document.children.first.children
    end

    private
    def fetch(url, options)
      response = Retriable.retriable on: OpenURI::HTTPError, tries: 3, interval: 1 do
        open("#{BASE_URL}/#{url}?#{normalize_params options}").read
      end
      parse_and_extract_response response
    end

    def normalize_params(params)
      query = ""
      params.each {|k, v| query += "#{k}=#{v}&"}
      query
    end

    def parse_and_extract_response(response)
      Nokogiri::Slop response
    end
  end
end
