class AddCollaboratorsToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :collaborators, :reference
  end
end
