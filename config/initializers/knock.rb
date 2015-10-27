Knock.setup do |config|

  ## Current user retrieval when validating token
  ## --------------------------------------------

  config.current_user_from_token = -> (claims) { User.find_by remote_id: claims['sub'] }

  ## Audience claim
  ## --------------

  config.token_audience = -> { ENV["AUTH0_APP_ID"] }


  ## Signature key
  ## -------------

  config.token_secret_signature_key = -> { JWT.base64url_decode(ENV["AUTH0_APP_SECRET"]) }

end
