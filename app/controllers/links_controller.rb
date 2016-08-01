class LinksController < ApplicationController

  def index
    @links = Link.all
    render 'index.html.erb'
  end

  def new
    @link = Link.new()
    render 'new.html.erb'
  end

  def create
    url_head = "http://localhost:3000/"
    @link = Link.new(
      user_id: current_user.id,
      target_url: params[:url]
      )
    @link.standardize_target_url!
    @link.generate_slug!
    @link.save
    redirect_to '/'
  end

end
