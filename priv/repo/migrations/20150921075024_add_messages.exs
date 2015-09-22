defmodule SlerkAPI.Repo.Migrations.AddMessages do
  use Ecto.Migration

  def change do
    create table(:messages, primary_key: false) do
      add :id,         :uuid,   primary_key: true
      add :text,       :string
      add :meta,       :map,    default: fragment("'{}'")
      add :user_id,    :string
      add :channel_id, :uuid

      timestamps
    end

    create index(:messages, [:channel_id])
  end
end
