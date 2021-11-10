class SpacesService
  class << self
    def create(space_params, manager_params)
      space   = Space.create!(space_params)
      manager = User.where(email: manager_params[:email]).first_or_create
      space.spaces_users.create!(
        username: manager_params[:username],
        user_password: manager_params[:password],
        user_role: 'manager',
        user_id: manager.id
      )
    end
  end
end
