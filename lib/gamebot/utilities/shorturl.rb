class ShortUrl
  @_default = :googl
  @_valid = [:googl]

  def self.default(service)
    if valid? service
      @_default = service
    else
      raise "ShortUrl Service does not exist: #{@_default}."
    end
  end

  def self.shorturl(contents, options = {})
    case @_default
      when :googl
        res = googl_short_url(contents, options)
      else
        raise "ShortUrl Service does not exist: #{@_default}."
    end

    res
  end

  def self.longurl(contents, options = {})
    case @_default
      when :googl
        res = googl_long_url(contents, options)
      else
        raise "ShortUrl Service does not exist: #{@_default}."
    end

    res
  end

  def self.googl_short_url(url, options = {})
    url = Googl.shorten(url, options[:ip], options[:api_key])

    return url.info if options[:info]
    return url if options[:all]

    url.short_url
  end

  def self.googl_long_url(url, _options = {})
    url = Googl.expand(url)
    url.long_url
  end

  def self.valid?(service)
    @_valid.find(service.downcase)
  end
end
