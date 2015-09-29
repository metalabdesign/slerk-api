defmodule Inflector do
  import Inflex

  def pascalize(str), do: camelize(str, :lower)
end
