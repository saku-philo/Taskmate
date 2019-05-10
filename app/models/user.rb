class User < ApplicationRecord
  has_secure_password
  before_destroy :check_disappear_admin
  before_validation { email.downcase! }
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum:6 }

  private

  def check_disappear_admin
    if self.admin? && User.where(admin: true).count == 1
      throw(:abort)
    end
  end
end
