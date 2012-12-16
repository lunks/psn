module PSN
  class Game
    attr_reader :id, :name
    def initialize(xml_node)
      parse_xml(xml_node)
    end
    private
    def parse_xml(xml_node)
      @id = xml_node.search('Id').text
      @name = xml_node.search('Title').text
    end
  end
end
