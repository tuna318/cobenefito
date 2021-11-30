module RequestMacros
  def register_space
    params = {
      space: { name: "space" },
      manager: {
        email: "hogehoge@gmail.com",
        username: "test",
        password: "12345678"
      }
    }
    post spaces_path(params)
  end
end
