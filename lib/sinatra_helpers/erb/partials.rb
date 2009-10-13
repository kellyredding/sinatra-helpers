require 'sinatra/base'

module SinatraHelpers::Erb::Partials
  
  # helper to emulate rails 'render :partial' helper, using erb
  # => taken from the sinatra book, http://sinatra-book.gittr.com/#implemention_of_rails_style_partials
  # Render the page once:
  # Usage: partial :foo
  # 
  # foo will be rendered once for each element in the array, passing in a local variable named "foo"
  # Usage: partial :foo, :collection => @my_foos    
  def partial(template, options={})
    options.merge!(:layout => false)
    path = template.to_s.split(File::SEPARATOR)
    object = path[-1].to_sym
    path[-1] = "_#{path[-1]}"
    template = File.join(path).to_sym
    raise 'partial collection specified but is nil' if options.has_key?(:collection) && options[:collection].nil?
    if collection = options.delete(:collection)
      counter = 0
      collection.inject([]) do |buffer, member|
        counter += 1
        buffer << erb(template, options.merge(:locals => {object => member, "#{object}_counter".to_sym => counter}))
      end.join("\n")
    else
      if member = options.delete(:object)
        options.merge!(:locals => {object => member})
      end
      erb(template, options)
    end
  end

end
  
Sinatra::Application.helpers SinatraHelpers::Erb::Partials
