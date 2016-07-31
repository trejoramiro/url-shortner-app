class LinksController < ApplicationController

  def index
    @links = Link.all
    return 'index.html.erb'
  end

end
