class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.string :test_attribute

      t.timestamps
    end
  end
end
