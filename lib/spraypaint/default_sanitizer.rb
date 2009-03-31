class Spraypaint::DefaultSanitizer
  attr_accessor :allowed_characters

  def initialize(allowed_characters = /[\w -]/)
    self.allowed_characters = allowed_characters
  end

  def sanitize(tag_or_array)
    if tag_or_array.is_a?(Array)
      sanitize_tag_array(tag_or_array)
    else
      sanitize_tag(tag_or_array)
    end
  end
  
  def sanitize_tag(tag)
    return nil if tag.nil?
    string = tag.strip
    string = string.mb_chars.normalize(:d).gsub(/[^\0-\x80]/, '')
    string = string.scan(self.allowed_characters).join
    string.empty? ? nil : string.to_s
  end
  
  def sanitize_tag_array(array)
    array.collect do |tag|
      sanitize_tag(tag)
    end.compact.uniq
  end
end