defmodule SlerkAPI.UserPresenceStore do
  @moduledoc """
  Naive implementation of user presence tracking. Assumes only one node.

  Increments reference counter each time the user connects to
  the websocket and decrements on disconnect.

  Stores last event timestamp to help determine availability.
  """

  @initial_state %{
    last_event_at: %{},
    ref_count: %{}
  }

  def start_link do
    Agent.start_link(fn -> @initial_state end, name: __MODULE__)
  end

  @doc "Increment state; will return immediately regardless of result."
  def inc_ref_count(uid) do
    Agent.get_and_update(__MODULE__, fn state ->
      count = get_in(state, [:ref_count, uid]) || 0
      state = put_in(state, [:ref_count, uid], count + 1)
      {state.ref_count[uid], state}
    end)
  end

  @doc "Decrement count and return resulting state"
  def dec_ref_count(uid) do
    Agent.get_and_update(__MODULE__, fn state ->
      count = get_in(state, [:ref_count, uid]) || 0
      if count > 0, do: state = put_in(state, [:ref_count, uid], count - 1)
      {state.ref_count[uid], state}
    end)
  end

  @doc "Update last event time for given user"
  def touch_last_event(uid) do
    Agent.cast(__MODULE__, fn state ->
      put_in(state, [:last_event_at, uid], :os.timestamp)
    end)
  end
end
