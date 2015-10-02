defmodule SlerkAPI.PresenceChannel do
  use SlerkAPI.Web, :channel

  alias SlerkAPI.UserPresence

  def join(_, _, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    UserPresence.inc_ref_count(socket.assigns.uid)
    {:noreply, socket}
  end

  def terminate(_, socket) do
    UserPresence.dec_ref_count(socket.assigns.uid)
    :ok
  end

  # Will eventually be used to away statuses
  def handle_in("tickle", _, socket) do
    UserPresence.touch_last_event(socket.assigns.uid)
    {:noreply, socket}
  end
end
