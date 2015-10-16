class AddSlerkModels < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :picture_key
      t.boolean :online
      t.datetime :last_event_at
      t.timestamps
    end

    create_table :channels do |t|
      t.string :name
      t.string :topic
      t.timestamps
    end

    create_table :messages do |t|
      t.integer :channel_id
      t.string :text
      t.json :meta
      t.timestamps
    end
  end
end
