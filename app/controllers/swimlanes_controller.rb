class SwimlanesController < ApplicationController
    before_action :require_login, raise: false
    
    def index
        @title = "title"
    end
end
