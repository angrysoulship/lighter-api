class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :wechat_name
      t.string :nickname
      t.string :wechat_avatar
      t.string :gender

      t.timestamps
    end
  end
end
