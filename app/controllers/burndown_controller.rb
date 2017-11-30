class BurndownController < ApplicationController
  before_action :require_login, raise: false
end
