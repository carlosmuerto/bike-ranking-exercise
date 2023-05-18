collection @user_rankings

node(:user) do |user_ranking|
  partial 'api/v1/users/show', object: user_ranking[:user]
end
node(:rank) { |user_ranking| user_ranking[:rank] }
node(:travelled_distance) { |user_ranking| user_ranking[:travelled_distance] }
