class AddTablefunc < ActiveRecord::Migration[5.0]
  def change
    execute "CREATE EXTENSION tablefunc"
  end
end
