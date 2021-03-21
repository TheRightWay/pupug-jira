class ChangeEnumRoles < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      ALTER TYPE account_roles RENAME VALUE 'accounting_clerk' TO 'analytic';
      ALTER TYPE account_roles RENAME VALUE 'repairman' TO 'manager';
      ALTER TYPE account_roles RENAME VALUE 'employee' TO 'developer';
    SQL
    change_column_default :accounts, :role, 'developer'
  end

  def down
    execute <<-SQL
      ALTER TYPE account_roles RENAME VALUE 'analytic' TO 'accounting_clerk';
      ALTER TYPE account_roles RENAME VALUE 'manager' TO 'repairman';
      ALTER TYPE account_roles RENAME VALUE 'developer' TO 'employee';
    SQL
    change_column_default :accounts, :role, 'employee'
  end
end
