class ApplicationController < ActionController::API
  include ErrorHandler

  def authorize_employee_request
    authorize_request
    raise CustomErrors::Unauthorized if @current_space_user[:user_role] != 'employee'
  end

  def authorize_manager_request
    authorize_request
    raise CustomErrors::Unauthorized if @current_space_user[:user_role] != 'manager'
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)

    @current_user = User.find(decoded[:user_id])
    @current_space = Space.find(decoded[:space_id])
    @current_space_user = SpacesUser.find_by(user_id: decoded[:user_id],
                                             space_id: decoded[:space_id])
    raise CustomErrors::Unauthorized unless @current_user && @current_space && @current_space_user
  end
end
