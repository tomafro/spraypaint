class Spraypaint::Sanitizer
  include Spraypaint::SanitizerSupport
  
  attr_accessor :allowed_characters

  def initialize(allowed_characters = /[\w -]/)
    self.allowed_characters = allowed_characters
  end

  def sanitize_tag(tag)
    return nil if tag.nil?
    string = tag.strip
    string = string.mb_chars.normalize(:d).gsub(/[^\0-\x80]/, '')
    string = string.scan(self.allowed_characters).join
    string.empty? ? nil : string.to_s
  end
end