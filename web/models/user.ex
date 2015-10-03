defmodule SlerkAPI.User do
  alias SlerkAPI.UserPresence

  defstruct name: nil, nickname: nil, picture: nil, online: false, last_event_at: nil

  def fetch(id) do
    %SlerkAPI.User{}
    |> Map.merge(fetch_remote(id))
    |> Map.delete(:user_id)
    |> Map.put(:id, id)
  end

  ## Given time constraints, service only pulls cached entries
  def fetch_all() do
    cached_users = ConCache.ets(:users) |> :ets.tab2list
    Enum.map(cached_users, fn ({uid, user}) ->
      user |> Map.put(:id, uid) |> Map.merge(UserPresence.get_presence(uid))
    end)
  end

  ## Fetch user details from Auth0 & user presence store in parallel
  defp fetch_remote(id) do
    [ Task.async(__MODULE__, :fetch_auth0_details, [id]),
      Task.async(UserPresence, :get_presence, [id]) ]
    |> Enum.map(&Task.await(&1, 5_000))
    |> Enum.concat |> Enum.into(%{})
  end

  def fetch_auth0_details(id) do
    ConCache.get_or_store(:users, id, fn ->
      case Auth0.get_user(id).body do
        user -> user
        # Only store errors briefly to avoid lots of painful lookups
        user = %{error: _} -> %ConCache.Item{value: user, ttl: :timer.seconds(1)}
      end
    end)
  end
end
