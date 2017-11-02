require "spec_helper"

describe "routes to the register controller" do
    it "routes to get registration" do
        expect(:get => "/register").to route_to(
            :controller => "users",
            :action => "new"
        )
    end
end