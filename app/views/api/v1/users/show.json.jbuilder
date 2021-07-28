json.extract! @user, :nickname
json.posts @user.posts do |post|
  json.extract! post, :id, :mood, :text, :date
end