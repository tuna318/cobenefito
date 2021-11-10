class SpacesController < ApplicationController
  def create
    SpacesService.create(space_params, manager_params)

    render json: {}, status: :created
  end

  private

  def space_params
    params.require(:space).permit(:name)
  end

  def manager_params
    params.require(:manager).permit(:email, :username, :password)
  end
end
