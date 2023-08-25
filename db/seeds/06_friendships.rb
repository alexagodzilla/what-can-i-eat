puts "creating friendship between Alex and Fran"
Friendship.create!(
  requester_id: ALEX.id,
  requested_id: FRAN.id,
  status: "accepted"
)

puts "creating friendship between Alex and Ila"
Friendship.create!(
  requester_id: ALEX.id,
  requested_id: ILA.id,
  status: "accepted"
)

puts "creating friendship between Alex and Jon"
Friendship.create!(
  requester_id: ALEX.id,
  requested_id: JON.id,
  status: "accepted"
)
