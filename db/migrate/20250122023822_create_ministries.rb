class CreateMinistries < ActiveRecord::Migration[8.0]
  def change
    create_table :ministries do |t|
      t.string :name
      t.text :description
      t.boolean :super_ministry, default: false

      t.timestamps
    end
  end
end
