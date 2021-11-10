module Manager
  class EmployeesService
    class << self
      def create(current_space, params)
        employee = User.where(email: params[:email]).first_or_create
        if SpacesUser.exists?(user_id: employee.id, space_id: current_space.id)
          raise CustomErrors::RecordExisted, "Employee already invited!"
        end

        current_space.spaces_users.create!(
          username: params[:username] || params[:email].match(/[^@]*/)[0],
          user_password: params[:password],
          user_role: 'employee',
          user_id: employee.id
        )
      end
    end
  end
end
