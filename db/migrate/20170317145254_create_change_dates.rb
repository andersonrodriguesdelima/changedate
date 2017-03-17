class CreateChangeDates < ActiveRecord::Migration[5.0]
  def change
    create_table :change_dates do |t|

      t.timestamps
    end
  end
end
