class ApplicationController < ActionController::API
  include ErrorHandler
  include ::ActionController::Cookies
end
