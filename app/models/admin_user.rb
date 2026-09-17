# Staff accounts for the admin dashboard (app/controllers/admin/*). Separate
# from User (patients/caretakers) — no signup; accounts are created via
# db/seeds.rb or `bin/rails console`. Named AdminUser (not Admin) because
# Admin is the controller namespace, and Zeitwerk won't allow both.
class AdminUser < ApplicationRecord
  has_secure_password

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, allow_nil: true
end
