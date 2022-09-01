class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :teste ]
  def teste
  end

  def home
  end
end
