require 'active_support/all'
require 'cgi'
require 'retriable/no_kernel'
require 'open-uri'
require 'net/http'
require 'nokogiri'
module PSN
  class API
    RETRIES = 3
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
      url = "#{BASE_URL}/#{url}?#{normalize_params options}"
      response = Retriable.retriable on: OpenURI::HTTPError, tries: RETRIES, interval: 1 do
        open(url).read
      end
      parse_and_extract_response response
    rescue OpenURI::HTTPError => e
      raise Error, url
    end

    def normalize_params(params)
      query = ""
      params.each {|k, v| query += "#{k}=#{CGI.escape v}&"}
      query
    end

    def parse_and_extract_response(response)
      Nokogiri::Slop response
    end
    class Error < RuntimeError
      def initialize(url)
        super("#{url} is not working after #{RETRIES} retries. Please check.")
      end
    end
  end
end
