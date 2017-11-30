class BurndownController < ApplicationController
  before_action :require_login, raise: false
  
  def index
    data = [
      {
        :date => '1/1/16',
        :amt  => 12
      },
      {
        :date => '1/2/16',
        :amt  => 13
      },
      {
        :date => '1/3/16',
        :amt => 8
      }
      ]
    @dates = "[" + data.map{|d| d[:date]}.inject(""){|sum,n| sum + "'" + n + "'" + ","} + "]"
    @data = "[" + data.map{|d| d[:amt]}.inject(""){|sum,n| sum + n.to_s + ","} + "]"
  end
end
