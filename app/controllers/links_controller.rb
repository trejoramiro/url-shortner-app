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
    puts "Warriror!!!!"
    @link = Link.new(
      user_id: current_user.id,
      target_url: params[:url]
      )
    @link.standardize_target_url!
    @link.generate_slug!
    @link.save
    redirect_to '/'
  end

  def visit
    if @link = Link.find_by(slug: params[:slug])
      @visit = Visit.new(link_id: @link.id, ip_address: request.remote_ip)
      @visit.save
      redirect_to "https://#{@link.target_url}"
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def show
    @link = Link.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def edit
    @link = Link.find_by(id: params[:id])
    render 'edit.html.erb'
  end

  def update
    @link = Link.find_by(id: params[:id])
    @link.assign_attributes({
      target_url: params[:q]
      })
    @link.save
    redirect_to '/'
  end

  def delete
    @link = Link.find_by(id: params[:id])
    @link.destroy
    redirect_to '/'
  end

end
