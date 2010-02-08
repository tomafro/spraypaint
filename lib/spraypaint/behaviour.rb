require 'spraypaint'

module Spraypaint::Behaviour
  autoload :Manipulation, 'spraypaint/behaviour/manipulation'
  autoload :Persistence, 'spraypaint/behaviour/persistence'
  autoload :Discovery, 'spraypaint/behaviour/discovery'
  
  include Manipulation, Persistence, Discovery
  
  def self.included(base)
    self.included_modules.each do |m|
      m.send :included, base
    end
  end
end