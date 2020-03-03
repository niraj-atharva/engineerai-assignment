class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.references :users
      t.text  :message

      t.timestamps
    end
  end
end
