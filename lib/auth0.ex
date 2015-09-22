defmodule Auth0 do
  import Joken, except: [verify: 1]

  def verify(jwt) do
    validate
    |> with_json_module(Poison)
    |> with_compact_token(jwt)
    |> Joken.verify
  end

  def validate do
    %Joken.Token{}
    |> with_json_module(Poison)
    |> with_signer(hs256(config[:secret]))
    |> with_validation("aud", &(&1 == config[:app_id]))
    |> with_validation("exp", &(&1 > current_time))
    |> with_validation("iat", &(&1 < current_time))
  end

  defp config, do: Application.get_env(:joken, :auth0)
end
