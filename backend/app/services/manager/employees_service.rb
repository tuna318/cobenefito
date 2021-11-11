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
          user_id: employee.id,
          user_reward_points: 0,
          user_claimable_points: 100
        )
      end

      def index(space)
        space.spaces_users.map { |user| user_response(user) }
      end

      def get_employee_details(space, user_id)
        space_user = space.spaces_users.find_by(user_id: user_id)
        raise ActiveRecord::RecordNotFound unless space_user

        user_coupons = space.coupons.where(user_id: user_id)

        [user_response(space_user), user_coupons]
      end

      private

      def user_response(space_user)
        {
          id: space_user.user.id,
          email: space_user.user.email,
          username: space_user.username,
          reward_points: space_user.user_reward_points,
          claimable_points: space_user.user_claimable_points
        }
      end
    end
  end
end
