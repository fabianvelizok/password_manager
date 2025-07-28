class AddRoleToUserPasswords < ActiveRecord::Migration[8.0]
  def up
    # 1) Add column without default so we can distinguish existing rows
    add_column :user_passwords, :role, :string

    # 2) Backfill existing rows as "owner"
    execute <<~SQL
      UPDATE user_passwords
      SET role = 'owner'
      WHERE role IS NULL
    SQL

    # 3) New rows: default "viewer" and enforce NOT NULL
    change_column_default :user_passwords, :role, "viewer"
    change_column_null :user_passwords, :role, false
  end

  def down
    remove_column :user_passwords, :role
  end
end
