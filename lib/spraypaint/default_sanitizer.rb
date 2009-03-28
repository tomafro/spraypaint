class Spraypaint::DefaultSanitizer
  attr_accessor :allowed_characters

  def initialize(allowed_characters = /[\w -]/)
    self.allowed_characters = allowed_characters
  end

  def sanitize(name)
    return nil if name.nil?
    string = name.strip
    string = string.mb_chars.normalize(:d).gsub(/[^\0-\x80]/, '')
    string = string.scan(self.allowed_characters).join
    string.empty? ? nil : string.to_s
  end
end