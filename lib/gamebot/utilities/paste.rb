require 'gist'

class Paste
  @_default = :gist
  @_valid = [:gist]

  def self.default(service)
    if valid service
      @_default = service
    else
      raise "Paste Service does not exist: #{self._default}."
    end
  end

  def self.paste(contents, *args)
    case self._default
      when :gist
        res = gist(contents, *args)
      else
        raise "Paste Service does not exist: #{self._default}."
    end

    res
  end

  # https://github.com/defunkt/gist/
  # Upload a gist to https://gist.github.com
  #
  # @param [Hash] files  the code you'd like to gist: filename => content
  # @param [Hash] options  more detailed options
  #
  # @option options [String] :description  the description
  # @option options [Boolean] :public  (false) is this gist public
  # @option options [Boolean] :anonymous  (false) is this gist anonymous
  # @option options [String] :access_token  (`File.read("~/.gist")`) The OAuth2 access token.
  # @option options [String] :update  the URL or id of a gist to update
  # @option options [Boolean] :copy  (false) Copy resulting URL to clipboard, if successful.
  # @option options [Boolean] :open  (false) Open the resulting URL in a browser.
  # @option options [Symbol] :output (:all) The type of return value you'd like:
  #   :html_url gives a String containing the url to the gist in a browser
  #   :short_url gives a String contianing a  git.io url that redirects to html_url
  #   :javascript gives a String containing a script tag suitable for embedding the gist
  #   :all gives a Hash containing the parsed json response from the server
  #
  # @return [String, Hash]  the return value as configured by options[:output]
  # @raise [Gist::Error]  if something went wrong
  #
  # @see http://developer.github.com/v3/gists/
  def self.gist(contents, options = {})
    options[:filename] = options[:filename] || 'ircgist.txt'
    options[:description] = options[:description] || 'Gisted contents from GamesBot'

    Gist.gist(contents, options)
  end

  def self.valid(service)
    @_valid.find(service.downcase)
  end
end
