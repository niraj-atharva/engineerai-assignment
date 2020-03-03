class PagesController < ApplicationController
  def home
    @tweets = Tweet.all.order(created_at: :desc)
  end
end
