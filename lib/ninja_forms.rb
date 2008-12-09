# NinjaForms
module NinjaForms
	
	#---
	# Excerpted from "Advanced Rails Recipes",
	# published by The Pragmatic Bookshelf.
	# Copyrights apply to this code. It may not be used to create training material, 
	# courses, books, articles, and the like. Contact us if you are in doubt.
	# We make no guarantees that this code is fit for any purpose. 
	# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
	#---
	class ExtendedFormBuilder < ActionView::Helpers::FormBuilder
		
		def calendar_select(method, options = {})
			@template.calendar_select(@object_name, method, objectify_options(options))
		end
		
	end
	
	class ErrorHandlingFormBuilder < ExtendedFormBuilder
	
	  helpers = field_helpers +
	    %w(calendar_select date_select datetime_select time_select collection_select submit select custom_check_box select_or_enter) -
	    %w(label fields_for hidden_field)
	
	  helpers.each do |name|
	  	case name
	  	when 'submit'
	      define_method name do |label, *args|
	        options = args.detect {|argument| argument.is_a?(Hash)} || {}
	        @template.capture do
	          #@template.render :partial => 'forms/submit.html.erb', :locals => options.merge(:element => super(label, options))
	          @template.render :partial => 'forms/submit.html.erb', :locals => options.merge(:element => super(label, options))
	        end
	      end
	    when 'custom_check_box'
	      define_method name do |label, *args|
	        options = args.detect {|argument| argument.is_a?(Hash)} || {}
	        @template.capture do
	          @template.render :partial => 'forms/check_box.html.erb', :locals => options.merge(:label => label(label, options.delete(:label), options.delete(:label_options)), :element => hidden_field(label))
	        end
	      end
	    when 'select_or_enter'
	      define_method name do |field, collection, selector, label, enter_field, *args|
	        options = args.detect {|argument| argument.is_a?(Hash)} || {}
	        @template.capture do
	          @template.render	:partial => 'forms/select_or_enter.html.erb',
	          					:locals => options.merge(	:label => label(field, options.delete(:label), options.delete(:label_options)||{}),
	          												:select => @template.collection_select(@object_name, field, collection.add_enter_option, selector, label, { :include_blank => '- kein(e) -' }, { :onchange => "if ($F(this)=='enter_new_value'){ $(this).next().enable().show().focus();$(this).disable().hide(); }" }),
	          												:enter_field => @template.text_field(@object_name, enter_field, :onkeyup => 'if(event.keyCode==27){ $(this).previous().enable().show().selectedIndex =0;$(this).disable().hide(); };', :disabled => true, :style => 'display:none;'),
	          												:field_needed => is_needed?(object, field),
	          												:formrow => {})
	        end
	      end
	  	else
	      define_method name do |field, *args|
	        options = args.detect {|argument| argument.is_a?(Hash)} || {}
	        options[:kind] = name.intern
	        build_shell(field, options) do
	          super
	        end
	      end
	  	end
	  end
	
		def build_shell(field, options)
			@template.capture do
				label_html = options.delete(:label_html)
				label = options.delete(:label)
				label_options = (options.delete(:label_options)||{}).merge(:class => 'visualIEFloatFix', :info => options.delete(:info))
				locals = {
					:kind		=> options.delete(:kind),
					:formrow	=> options.delete(:formrow)||{},
					:element	=> yield,
					:label		=> label_html||label(field, label, label_options)
				}
				if has_errors_on?(field)
					field_needed = is_needed?(object, field)
					locals.merge!(:error => error_message(field, options))
					@template.render :partial => 'forms/field_with_errors.html.erb', :locals  => locals.merge(:field_needed => field_needed)
				else
					field_needed = is_needed?(object, field)
					@template.render :partial => 'forms/field.html.erb', :locals  => locals.merge(:field_needed => field_needed)
				end
			end
		end
		
		def is_needed?(object, field)
			# validate the model and check for errors on the attribute
			o = clone_object(object)
			o.valid?
			!o.errors.on(field).blank?
		end
	  
	  def error_message(field, options)
	    if has_errors_on?(field)
	      errors = object.errors.on(field)
	      errors.is_a?(Array) ? errors.to_sentence : errors
	    else
	      ''
	    end
	  end
	  
	  def clone_object(from)
	  	to = from.class.new
	  	#from.attributes.each {|attr, value| to.send("#{attr}=", from.send(attr)) }
	  	to
	  end
	  
	  def has_errors_on?(field)
	    !(object.nil? || object.errors.on(field).blank?)
	  end
	  
	  def gettext_string_for_label(field)
	    unless object.nil?
	      object.class.to_s.humanize + '|' + field.to_s.humanize
	    else
	      field.to_s
	    end
	  end
	  
	  # 
	  def label_for_name(field)
	    unless object.nil?
	      object.class.to_s.underscore  + '_' + field.to_s.underscore
	    else
	      field.to_s
	    end
	  end
	end
	
end