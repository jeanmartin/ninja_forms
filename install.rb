# Install hook code here

puts "Copying views/forms..."
src = File.join(File.dirname(__FILE__), 'templates', 'views', 'forms')
dst = File.join(RAILS_ROOT, 'app', 'views')
FileUtils.cp_r(src, dst)

puts "Copying stylesheets/*..."
src = File.join(File.dirname(__FILE__), 'templates', 'stylesheets', 'ninja_forms.css')
dst = File.join(RAILS_ROOT, 'public', 'stylesheets')
FileUtils.cp_r(src, dst)

puts "Copying images/icons/*..."
src = File.join(File.dirname(__FILE__), 'templates', 'images', 'icons', 'help.gif')
dst = File.join(RAILS_ROOT, 'public', 'images', 'icons')
FileUtils.cp_r(src, dst)

puts "Installation complete!"

