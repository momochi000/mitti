module Users
  class Admin < User
    def admin?
      true
    end
  end
end
