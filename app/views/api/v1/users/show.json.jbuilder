json.extract! @user, :nickname
json.reviews @user.posts do |post|
  json.extract! post, :mood, :text, :date
end