module Manager
  class EmployeesService
    class << self
      def create(current_space, params)
        employee = User.where(email: params[:email]).first_or_create
        space_employee = SpacesUser.find_by(user_id: employee.id, space_id: current_space.id)
        initial_password = random_password

        if space_employee.present?
          update_space_user_password(space_employee, initial_password)
        else
          create_space_user(current_space, employee, initial_password)
        end

        send_invitation_email(current_space, employee, initial_password)
      end

      def index(space, params)
        employees = space.spaces_users
                         .where(user_role: 'employee')
                         .where("username LIKE :username", username: "%#{params[:username]}%")

        employees.map { |user| user_response(user) }
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

      def send_invitation_email(space, employee, password)
        UserMailer.with(user: employee, space: space, password: password)
                  .invitation_email.deliver_later
      end

      def create_space_user(space, employee, password)
        space.spaces_users.create!(
          username: employee.email.match(/[^@]*/)[0],
          user_password: password,
          user_role: 'employee',
          user_id: employee.id,
          user_reward_points: 100,
          user_claimable_points: 100
        )
      end

      def update_space_user_password(space_user, password)
        space_user.user_password = password
        space_user.save!
      end

      def random_password
        specials = ((32..47).to_a + (58..64).to_a + (91..96).to_a + (123..126).to_a).pack('U*').chars.to_a
        numbers  = (0..9).to_a
        alpha    = ('a'..'z').to_a + ('A'..'Z').to_a
        %w[i I l L 1 O o 0].each  do |ambiguous_character|
          alpha.delete ambiguous_character
        end
        characters = (alpha + specials + numbers)
        password = Random.new.rand(8..10).times.map { characters.sample }
        password << specials.sample unless password.join =~ Regexp.new(Regexp.escape(specials.join))
        password << numbers.sample  unless password.join =~ Regexp.new(Regexp.escape(numbers.join))
        password.shuffle.join
      end
    end
  end
end
