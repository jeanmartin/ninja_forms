module NinjaFormHelper
  
  # error_handling_form from Rails Recipes
  def error_handling_form_for(record_or_name_or_array, *args, &proc)
    options = args.detect { |argument| argument.is_a?(Hash) }
    if options.nil?
      options = {:builder => NinjaForms::ErrorHandlingFormBuilder}
      args << options
    end
    options[:builder] = NinjaForms::ErrorHandlingFormBuilder unless options.nil?
    form_for(record_or_name_or_array, *args, &proc)
  end
  
  # remote version of error_handling_form
  def error_handling_remote_form_for(record_or_name_or_array, *args, &proc)
    options = args.detect { |argument| argument.is_a?(Hash) }
    if options.nil?
      options = {:builder => NinjaForms::ErrorHandlingFormBuilder}
      args << options
    end
    options[:builder] = NinjaForms::ErrorHandlingFormBuilder unless options.nil?
    remote_form_for(record_or_name_or_array, *args, &proc)
  end
  
  # 
  def calendar_select(object_name, method, options = {})
  	calendar_class = options.delete(:calendar_class)||'calendar_select'
	text_field(object_name, method, options.merge( :class => calendar_class ))
  end
	
end