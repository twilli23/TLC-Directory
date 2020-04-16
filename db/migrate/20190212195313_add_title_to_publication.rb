# frozen_string_literal: true

class AddTitleToPublication < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :title, :string
  end
end
