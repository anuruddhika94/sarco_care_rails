class RenameAdminsToAdminUsers < ActiveRecord::Migration[8.1]
  def change
    # `Admin` collides with the app/controllers/admin/* namespace under
    # Zeitwerk (can't be both a class and a module) — the model is
    # `AdminUser` instead, kept at /admin/* routes.
    rename_table :admins, :admin_users
  end
end
