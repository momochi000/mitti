class User < ApplicationRecord
  self.store_full_sti_class = false
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Along with self.store_full_sti_class = false, this is necessary so that
  # user rows in the database don't need to have type='Users::AdminUser' etc.
  # This could have been avoided by simply adding subclasses of User to
  # /models rather than nesting them under /models/users/ However, this will
  # eventually lead to a very crowded and difficult to understand /models
  # folder.
  def self.find_sti_class(type_name)
    type_name = "Users::#{type_name}" unless type_name.include?("::") || type_name == 'User'
    super(type_name)
  end
end

