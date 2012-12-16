require 'spec_helper'
require 'psn/user'

module PSN
  describe User do
    it 'stores the id', :vcr do
      User.new("RazrPSN").id.should == "RazrPSN"
    end

    describe "avatar", :vcr do
      it "has an avatar" do
        User.new("RazrPSN").avatar.should == "http://static-resource.np.community.playstation.net/avatar/WWS_E/E0039.png"
      end

    end
    describe "games", :vcr do
      let(:games) {User.new("RazrPSN").games}
      it "fetches the right amount of games" do
        games.count.should == 46
      end
    end
  end
end
