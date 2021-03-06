module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    def link_to(name, url, options={})
      tag(:a, name, options.merge(:href => url))
    end
    
    def image(filename)
      tag(:img, nil, :src => "/images/"+filename)
    end
  end
end
