module SinatraHelpers::Erb::Helpers
  
  def sinatra_erb_helper_safe_id(id)
    id.gsub(/\W/,'')
  end
  
  def sinatra_erb_helper_capture(*args, &block)
    sinatra_erb_helper_with_output_buffer { block.call(*args) }
  end
  
  def sinatra_erb_helper_with_output_buffer(buf = '') #:nodoc:
    @_out_buf, old_buffer = buf, @_out_buf
    yield
    @_out_buf
  ensure
    @_out_buf = old_buffer
  end
  
  def sinatra_erb_helper_hash_to_html_attrs(a_hash)
    a_hash.collect{|key, val| "#{key}=\"#{val}\""}.join(' ')
  end

  def sinatra_erb_helper_disabled_option
    'disabled' 
  end
  
  def sinatra_erb_helper_checked_option
    'checked'
  end
  
  def sinatra_erb_helper_multiple_option
    'multiple'
  end
  
  def sinatra_erb_helper_multipart_option
    'multipart/form-data'
  end
  
end      
