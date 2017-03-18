class HomeController < ApplicationController

  def index
  end

  def resultado
    @datachange = ChangeDate.change_date(params[:date], params[:op], params[:value])
  end
end
