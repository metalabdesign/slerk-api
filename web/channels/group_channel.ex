defmodule SlerkAPI.GroupChannel do
  use SlerkAPI.Web, :channel

  alias SlerkAPI.Repo
  alias SlerkAPI.Message
  alias SlerkAPI.Serializer
  alias JaSerializer.EctoErrorSerializer

  def join("channels:" <> _, _, socket) do
    {:ok, socket}
  end

  ## Message
  def handle_in("message", params, socket) do
    case create_message(params, socket) do
      {:ok, record} ->
        broadcast! socket, "message", Serializer.Message.format(record)
        {:noreply, socket}
      {:error, record} ->
        {:reply, {:error, EctoErrorSerializer.format(record)}, socket}
    end
  end

  ## Typing events
  def handle_in("typing", _, socket) do
    broadcast! socket, "user_typing", Dict.take(socket.assigns, [:uid])
    {:noreply, socket}
  end

  ## Presence
  def handle_in("tickle", _, socket) do
    # TODO: Update user's availability
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
end
