class AuthService
  class << self
    def authenticate(params)
      user = User.find_by(email: params[:user_email])
      space = Space.find_by(name: params[:space_name])

      unless space_user_authenticated?(space, user, params[:user_password])
        raise ActiveRecord::RecordNotFound, 'Authentication info incorrect'
      end

      token = JsonWebToken.encode(user_id: user.id, space_id: space.id)
      time = Time.zone.now + 24.hours.to_i

      [token, time.strftime("%m-%d-%Y %H:%M")]
    end

    private

    def space_user_authenticated?(space, user, password)
      return false unless user && space

      space_user = SpacesUser.find_by(space_id: space.id, user_id: user.id)
      space_user&.authenticate_user_password(password)
    end
  end
end
