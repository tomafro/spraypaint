module Spraypaint::SanitizerSupport
  
  # Sanitizes an array of tags, passing each one through #sanitize_tag and removing
  # all nils and duplicates.
  
  def sanitize_array(array)
    array.collect do |tag|
      sanitize_tag(tag)
    end.compact.uniq
  end
end