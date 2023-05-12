class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails (Cookies)" 
    session[:curso] = "Curso de Ruby on Rails (Session)" 
    @meu_nome=params[:nome]
    @curso=params[:curso]
  end
end
