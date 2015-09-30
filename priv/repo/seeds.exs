# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SlerkAPI.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

SlerkAPI.Repo.insert!(%SlerkAPI.Channel{
  id: "9d0bea9c-4a68-4129-bc58-0f929ee11ffd",
  name: "general",
  creator_id: "github|194892"
})
