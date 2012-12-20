require 'spec_helper'
module PSN
  describe Game, :vcr do
    let(:user) { User.new('RazrPSN') }
    let (:game) {GamesList.new(user).games.first}
    it "finds the correct id" do
      game.id.should == "NPWR03002_00"
    end
    it "finds the correct name" do
      game.name.should == "Tales from Space: Mutant Blobs Attack"
    end
    it "finds the correct platform" do
      game.platform.should == :ps_vita
    end
  end
end
