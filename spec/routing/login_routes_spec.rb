require "spec_helper"

describe "routes to the login controller" do
    it "routes to get login" do
        expect(:get => "/login").to route_to(
            :controller => "sessions",
            :action => "new"
        )
    end
  
    it "routes to post login" do
        expect(:post => "/login").to route_to(
            :controller => "sessions",
            :action => "create"
        )
    end
end