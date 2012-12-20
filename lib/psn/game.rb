module PSN
  class Game
    attr_reader :id, :name, :platform
    def initialize(xml_node)
      parse_xml(xml_node)
    end

    private
    def parse_xml(xml_node)
      @id = xml_node.search('Id').text
      @name = xml_node.search('Title').text
      @platform = correct_platform xml_node.search('Platform').text.to_sym
    end
    def correct_platform(platform)
      {:psp2 => :ps_vita, :ps3 => :ps3}[platform]
    end
  end
end
