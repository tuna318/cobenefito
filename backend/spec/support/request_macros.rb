module RequestMacros
  def register_space_with_manager_account
    params = {
      space: space_info,
      manager: {
        email: manager_login_info[:user_email],
        username: "hogehoge",
        password: manager_login_info[:user_password]
      }
    }
    post spaces_path(params)
  end

  def register_employee_to_space(space, user)
    create(:spaces_user_employee, user: user, space: space)
  end

  def login_to_space_as_manager
    login_to_space_with(manager_login_info)
  end

  def login_to_space_as_employee
    login_to_space_with(employee_login_info)
  end

  def login_to_space_with(login_info)
    post auth_login_path(login_info)
    @token = JSON.parse(response.body)["token"]
  end

  private

  def space_info
    { name: "space" }
  end

  def manager_login_info
    {
      space_name: "space",
      user_email: "manager@example.com",
      user_password: "password"
    }
  end

  def employee_login_info
    {
      space_name: "space",
      user_email: "employee@example.com",
      user_password: "password"
    }
  end
end
