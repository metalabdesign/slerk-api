defmodule SlerkAPI.Repo.Migrations.AddChannels do
  use Ecto.Migration

  def change do
    create table(:channels, primary_key: false) do
      add :id,    :uuid,  primary_key: true
      add :name,  :string
      add :topic, :string
      add :creator_id, :string

      timestamps
    end
  end
end
