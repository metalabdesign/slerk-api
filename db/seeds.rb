# Thompsons

User.find_or_create_by(id: 1).update(
  picture_key: "4GMt4xk.png",
  name: "Homer Simpson",
  nickname: "homer",
  remote_id: "github|194892",
  last_event_at: 5.minutes.ago,
  online: true
)

User.find_or_create_by(id: 2).update(
  picture_key: "CcjKwtv.png",
  name: "Bart Simpson",
  nickname: "bart",
  last_event_at: 2.minutes.ago,
  online: true
)

User.find_or_create_by(id: 3).update(
  picture_key: "m78yUxO.png",
  name: "Lisa Simpson",
  nickname: "lisa",
  last_event_at: 10.minutes.ago,
  online: false
)

User.find_or_create_by(id: 4).update(
  picture_key: "fSyH1GI.png",
  name: "Krusty the Clown",
  nickname: "krusty",
  last_event_at: 20.minutes.ago,
  online: false
)

User.find_or_create_by(id: 5).update(
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

Message.find_or_create_by(id: 1).update(
  text: "HEY! HEY!",
  channel_id: 1,
  author_id: 4
)

Message.find_or_create_by(id: 2).update(
  text: "howdy",
  channel_id: 1,
  author_id: 3
)

Message.find_or_create_by(id: 3).update(
  text: "You tried your best and you failed miserably. The lesson is never try.",
  channel_id: 1,
  author_id: 1
)

Message.find_or_create_by(id: 4).update(
  text: "Mental note: the girl knows too much.",
  channel_id: 1,
  author_id: 1
)

Message.find_or_create_by(id: 5).update(
  text: "![](https://media.giphy.com/media/xTiTnjHijj5I9CEixW/giphy.gif)",
  channel_id: 1,
  author_id: 2
)

Message.find_or_create_by(id: 6).update(
  text: "WHY YOU LITTLE!~~",
  channel_id: 1,
  author_id: 1
)
