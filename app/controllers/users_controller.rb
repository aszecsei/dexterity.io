class UsersController < ApplicationController
    def new
    end
    def create
        redirect_to login_url
    end
end
