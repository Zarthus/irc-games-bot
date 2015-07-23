module StringRefinement
  refine String do
    def camelize
      split('_')
        .map(&:capitalize)
        .join('')
    end

    def underscore
      gsub(/([A-Z])/, '_\1')
        .sub(/^_/, '')
        .downcase
    end
  end
end

class String
  def to_gist
    Paste.gist(to_s)['html_url']
  end

  def to_paste
    Paste.paste(to_s)
  end
end
