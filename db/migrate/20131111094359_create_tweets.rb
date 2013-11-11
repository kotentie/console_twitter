class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.string :tweet_time
      t.string :image
      t.integer :twitter_user_id
      t.timestamps
    end
  end
end
