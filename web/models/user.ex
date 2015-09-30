defmodule SlerkAPI.User do
  alias SlerkAPI.UserPresence

  defstruct name: nil, nickname: nil, picture: nil, online: false, last_event_at: nil

  def fetch(id) do
    %SlerkAPI.User{}
    |> Map.merge(fetch_remote(id))
    |> Map.delete(:user_id)
    |> Map.put(:id, id)
  end

  ## Fetch user details from Auth0 & user presence store in parallel
  defp fetch_remote(id) do
    [ Task.async(fn -> Auth0.get_user(id).body end),
      Task.async(UserPresence, :get_presence, [id]) ]
    |> Enum.map(&Task.await(&1, 5_000))
    |> Enum.concat |> Enum.into(%{})
  end
end
