class LanguagesController < ApplicationController
  def switch
    session[:locale] = params[:locale] if I18n.available_locales.include?(params[:locale].to_sym)
    redirect_back(fallback_location: root_path)
  end
end
