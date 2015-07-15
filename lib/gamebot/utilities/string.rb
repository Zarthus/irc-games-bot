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
end