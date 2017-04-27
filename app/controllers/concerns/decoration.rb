module Decoration
  extend ActiveSupport::Concern

  def decorate(obj)
  	ActiveDecorator::Decorator.instance.decorate obj
  end

  def pluck(obj, *attrs)
  	obj.collect do |u| 
  		res = []
  		attrs.each do |attr|
  			res << u.send(attr)
  		end
  		res
  	end
  end
end
