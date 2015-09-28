defmodule SlerkAPI.GroupChannel do
  use SlerkAPI.Web, :channel

  alias SlerkAPI.Repo
  alias SlerkAPI.Message
  alias SlerkAPI.UserPresenceStore
  alias JaSerializer.EctoErrorSerializer

  def join("channels:" <> _, _, socket) do
    {:ok, socket}
  end

  ## Message
  def handle_in("message", params, socket) do
    touch_last_event_at socket
    case create_message(params, socket) do
      {:ok, _} ->
        {:noreply, socket}
      {:error, record} ->
        {:reply, {:error, EctoErrorSerializer.format(record)}, socket}
    end
  end

  ## Typing events
  def handle_in("typing", _, socket) do
    touch_last_event_at socket
    broadcast! socket, "user_typing", Dict.take(socket.assigns, [:uid])
    {:noreply, socket}
  end

  defp create_message(params, socket) do
    params = params |> Dict.take(["id", "text"]) |> Map.merge(extract_context(socket))
    record = Message.changeset(%Message{}, params)
    Repo.insert(record)
  end

  defp extract_channel_id(%{topic: "channels:" <> id}), do: id
  defp extract_context(socket),
    do: %{"channel_id" => extract_channel_id(socket), "user_id" => socket.assigns.uid}

  defp touch_last_event_at(socket),
    do: UserPresenceStore.touch_last_event(socket.assigns.uid)
end
