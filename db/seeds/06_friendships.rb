require_relative "02_users"

def create_friendships(array)
  array.each do |second_person|
    Friendship.create!(
      requester_id: ALEX.id,
      requested_id: second_person.id,
      status: "accepted"
    )
    puts "Creating friendship between Alex and #{second_person.first_name}"
  end
end

create_friendships([FRAN, ILA, JON])
