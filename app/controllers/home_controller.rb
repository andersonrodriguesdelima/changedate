class HomeController < ApplicationController

  def index
  end

  def resultado
    @datachange = ChangeDate.change_date(params[:date], params[:operacao], params[:minutos])
  end
end
