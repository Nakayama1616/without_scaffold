class CreateMyThreads < ActiveRecord::Migration[7.0]
  def change
    create_table :my_threads do |t|
      t.string "tittle"
      t.text "body"
      t.datetime "created_at", null:false
    end
  end
end
