class String
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

  def to_gist
    Paste.gist(to_s)
  end

  def paste
    Paste.paste(to_s)
  end
end
