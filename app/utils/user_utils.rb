module UserUtils
  module_function

  def photo_url(user, size)
    key, format = user.picture_key.split(".")
    size = case size
    when "large"
      "l"
    when "medium"
      "m"
    when "small"
      "t"
    else
      ""
    end
    "http://i.imgur.com/#{key}#{size}.#{format}"
  end
end
