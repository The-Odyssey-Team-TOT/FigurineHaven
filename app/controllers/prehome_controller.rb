class PrehomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @show_navbar = false
    @show_footer = false
  end
end
