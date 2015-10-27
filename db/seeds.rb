# Thompsons

User.create(
  picture_key: "4GMt4xk.png",
  name: "Homer Simpson",
  nickname: "homer",
  remote_id: "github|194892",
  last_event_at: 5.minutes.ago,
  online: true
)

User.create(
  picture_key: "CcjKwtv.png",
  name: "Bart Simpson",
  nickname: "bart",
  last_event_at: 2.minutes.ago,
  online: true
)

User.create(
  picture_key: "m78yUxO.png",
  name: "Lisa Simpson",
  nickname: "lisa",
  last_event_at: 10.minutes.ago,
  online: false
)

User.create(
  picture_key: "fSyH1GI.png",
  name: "Krusty the Clown",
  nickname: "krusty",
  last_event_at: 20.minutes.ago,
  online: false
)

User.create(
  picture_key: "HHuQX7h.png",
  name: "Comic Book Guy",
  nickname: "comic.b.guy",
  last_event_at: 10.minutes.ago,
  online: true
)

Channel.find_or_create_by(id: 1).update(
  name: "watercooler",
  topic: "You tried your best and you failed miserably. The lesson is never try."
)

Channel.find_or_create_by(id: 2).update(
  name: "krusty",
  topic: "Krusty Komedy Klassic"
)

Message.create(
  text: "I like cakes.",
  channel_id: 1
)
