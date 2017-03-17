class HomeController < ApplicationController
  def index
    @datachange = ChangeDate.new
  end
  def index_do
    raise "aqui"
  end
end
