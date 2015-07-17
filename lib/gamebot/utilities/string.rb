class String
  def camelize
    self.split('_')
        .map(&:capitalize)
        .join('')
  end

  def underscore
    self.gsub(/([A-Z])/, '_\1')
        .sub(/^_/, '')
        .downcase
  end

  def to_gist
    Paste.gist(self.to_s)
  end

  def paste
    Paste.paste(self.to_s)
  end
end
