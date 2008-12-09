require 'test/unit'

require File.dirname(__FILE__) + '/../lib/ninja_form_helper'

# class NinjaFormsTest < Test::Unit::TestCase
#   # Replace this with your real tests.
#   def test_this_plugin
#     flunk
#   end
# end

class NinjaFormTest < Test::Unit::TestCase

  # Explicitly include the module
  include ActionView::Helpers::FormHelper
  include NinjaFormHelper

  def test_calendar_select
    assert_equal text_field('user', 'created_at', :class => 'calendar_select' ), calendar_select('user', 'created_at')
  end

end