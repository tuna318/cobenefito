require 'rails_helper'

RSpec.describe "Manager::Employees", type: :request do
  before do
    register_space_with_manager_account
    login_to_space_as_manager
  end

  describe "GET /manager/employees" do
    let(:send_get_employees) { get manager_employees_path, headers: { "Authorization": @token } }
    let(:space) { Space.find_by(name: space_info[:name]) }
    let(:employee) { create(:user) }
    before { register_employee_to_space(space, employee) }

    it "should return employee list" do
      send_get_employees
      return_employees_count = JSON.parse(response.body).size
      space_employees_count = space.spaces_users.where(user_role: :employee).size
      expect(return_employees_count).to eq(space_employees_count)
    end
  end
end
