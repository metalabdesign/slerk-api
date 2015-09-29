defmodule Auth0 do
  use HTTPotion.Base

  import Joken

  def process_url(url) do
    "https://slerk.auth0.com/api/v2/" <> url
  end

  def process_response_body(body) do
    body |> Poison.decode!(keys: :atoms!)
  end

  def get_user(id, fields \\ ~w(user_id name nickname picture)) do
    token = build_bearer_token(%{scopes: %{users: %{actions: ["read"]}}})
    query = %{fields: fields |> Enum.join(",")} |> URI.encode_query
    get("users/#{id}?#{query}", headers: %{:"Authorization" => "Bearer " <> token})
  end

  defp build_bearer_token(scopes) do
    %Joken.Token{claims: scopes}
    |> with_json_module(Poison)
    |> with_aud(config[:apikey])
    |> with_signer(hs256(config[:secret]))
    |> with_iat
    |> sign
    |> get_compact
  end

  defp config, do: Application.get_env(:auth0, :client)
end
