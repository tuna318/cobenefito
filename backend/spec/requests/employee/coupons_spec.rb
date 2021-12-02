require 'rails_helper'

RSpec.describe "Employee::Coupons", type: :request do
  let(:space) { Space.find_by(name: space_info[:name]) }
  let(:employee) { User.create(email: employee_login_info[:user_email]) }

  before do
    register_space_with_manager_account
    register_employee_to_space(space, employee)
    create(:coupon, space: space, user: employee)
    login_to_space_as_employee
  end

  describe "GET /employee/coupons" do
    let(:send_get_employees_coupons) do
      get employee_coupons_path, headers: { "Authorization": @token }
    end

    it "should return coupon list" do
      send_get_employees_coupons
      return_coupons_count = JSON.parse(response.body).size
      employee_coupons_count = employee.coupons.size
      expect(return_coupons_count).to eq employee_coupons_count
    end
  end
end
