json.extract! @user, :nickname
json.posts @user.posts.order(:date) do |post|
  json.extract! post, :id, :mood, :text, :date, :user_id, :created_at, :updated_at
end