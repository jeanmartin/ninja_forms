# Include hook code here

# change the surrounding container for field errors to <span></span>
ActionView::Base.field_error_proc = Proc.new{|html_tag, instance| "<span class=\"fieldWithErrors\">#{html_tag}</span>" }

# load array extension
require File.dirname(__FILE__) + '/lib/array_extension'

# include form helpers
ActionView::Base.send :include, NinjaFormHelper