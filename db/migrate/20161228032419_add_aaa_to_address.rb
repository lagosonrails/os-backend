class AddAaaToAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :archive_number, :string
    add_column :addresses, :archived_at, :datetime
  end
end
