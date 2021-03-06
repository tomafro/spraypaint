require 'spraypaint'

module Spraypaint::Behaviour
  include Manipulation, Persistence, Discovery
  
  def self.included(base)
    self.included_modules.each do |m|
      m.send :included, base
    end
  end
end