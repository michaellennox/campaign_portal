class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :ref

      t.timestamps null: false
    end
  end
end
