class WelcomeController < ApplicationController
  def home
  end

  def about
  end

  def contact_us
    @full_name = params[:full_name]
    @email = params[:email]
    @message = params[:message]

    render :thank_you
  end

  def bill_splitter

  end
end
