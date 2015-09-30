defmodule SlerkAPI.Serializer do
  defmacro __using__(opts) do
    quote do
      def format(record), do: format(record, %{}, %{})
      def format(record, conn), do: format(record, conn, %{})
      def format(record, conn, _) when is_list(record) do
        Enum.map(record, &format(&1, conn, %{}))
      end
    end
  end
end
