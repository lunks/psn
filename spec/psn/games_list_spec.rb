require 'spec_helper'
module PSN
  describe GamesList, :vcr do
    let(:user) { User.new("RazrPSN") }
    let(:games) {GamesList.new(user).games}
    it "has the right amount of games" do
      games.count.should == 46
    end
    it "creates game objects" do
      games.all?{|g| g.should be_a_kind_of Game}
    end
  end
end
