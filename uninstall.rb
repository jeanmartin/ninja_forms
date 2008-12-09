# Uninstall hook code here

FileUtils.rm_r File.join(RAILS_ROOT, 'app', 'views', 'forms'), :force => true
FileUtils.rm   File.join(RAILS_ROOT, 'public', 'stylesheets', 'ninja_forms.css'), :force => true
FileUtils.rm   File.join(RAILS_ROOT, 'public', 'images', 'icons', 'help.gif'), :force => true

