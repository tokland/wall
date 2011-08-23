class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  
protected

  def forbid
    render :text => "Forbidden", :status => 403
  end
end
