require 'erb'
require 'sinatra/base'

module SinatraHelpers; end
module SinatraHelpers::Erb; end

module SinatraHelpers::Erb::Partials
  
  # helper to somewhat emulate rails' 'render :partial' helper, using erb
  # => originally taken from the sinatra book:
  #    http://sinatra-book.gittr.com/#implemention_of_rails_style_partials
  # => updated: pass a block to specify the partial subject (ie object or collection)
  # => updated: pass a hash to specify locals directly
  # => if a block is passed, will look for template in a path relative to
  #    to the calling template path.  Specify template with a leading '/'
  #    to force the path to be relative to the views directory.
  #
  # Render the partial once (no subject) with no locals:
  # Usage: partial :item
  # => looks for template at <views>/_item.erb
  # Render a nested template
  # Usage: partial '/items/item'
  # => looks for template at <views>/items/_item.erb
  #
  # Render the partial once (no subject) WITH locals:
  # Usage: partial :item, :user => @me
  #
  # Render the partial once on an object:
  # Implicit usage: partial :item { @item }
  # => knows subject should be treated as an object (and not a collection)
  #    b/c @item is not enumerable
  # Explicit usage: partial :item, :item => @item_set
  #       -- or --: partial :item, :object => @item_set
  # => use a local if your subject is enumerable and you want
  #    it treated as a single object
  #
  # Render the partial over a collection:
  # => knows subject should be treated as a collection (and not a single object)
  #    b/c @items is enumerable
  # Implicit usage: partial :item { @items }
  # Explicit usage: partial :item, :collection => @items
  #
  # Generally, passing a block is the preferred method b/c
  # you can specify templates relative to the calling template's
  # path, for example:
  # => if in template <views>/items/_item_list.erb
  # => partial :item { @items }
  # => will look for the template at <views>/items/_item.erb
  # => however
  # => partial :item, :collection => @items
  # => will look for the template at <views>/_item.erb
  # => you can force this behavior in the block version
  # => by prepending a '/' to the template
  # => partial '/item' { @items }
  # => will look for the template at <views>/_item.erb
  
  def partial(path, locals={}, &subject_block)
    raise "locals must be specified with a Hash" unless locals.kind_of?(::Hash)
    params = _partial_params(path, locals, subject_block)
    # locals[:object] takes precedence over whatever calculated subject
    if locals.delete(:object).nil? && params[:subject] && params[:subject].respond_to?(:collect)
      counter = 0
      params[:subject].collect do |subject|
        erb(params[:path], params[:options].merge({
          :locals => params[:locals].merge({
            params[:name].to_sym => subject,
            "#{params[:name]}_counter".to_sym => counter += 1
          })
        }))
      end.join("\n")
    else
      erb(params[:path], params[:options].merge({
        :locals => params[:locals].merge({
          params[:name].to_sym => params[:subject]
        })
      }))
    end
  end
  
  private
  
  def _partial_params(path, locals, subject_block)
    {
      :name => name = File.basename(path.to_s).split(".").first.to_sym,
      :subject => begin
        subject_block.call
      rescue
        nil
      end ||
      locals.delete(:collection) ||
      locals[:object] ||   # don't remove it from the locals hash just yet
      locals.delete(name),
      :locals => locals.delete(:locals) || locals,
      :options => { :layout => false },
      :path => _partial_path(path, subject_block).to_sym
    }
  end

  def _partial_path(path, subject_block)
    partial_path = if path.to_s =~ /\A\// || subject_block.nil?
      path.to_s
    else
      File.join(*[
        eval("File.expand_path(File.dirname(__FILE__))", subject_block).
        gsub(File.expand_path(Sinatra::Application.views), ''),
        path.to_s
      ])
    end
    File.join(File.dirname(partial_path), "_#{File.basename(partial_path)}")
  end

end
  
Sinatra::Application.helpers SinatraHelpers::Erb::Partials

