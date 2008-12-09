# Uninstall hook code here

FileUrils.rm_r File.join(RAILS_ROOT, 'app', 'views', 'forms'), :force => true
FileUrils.rm   File.join(RAILS_ROOT, 'public', 'stylesheets', 'ninja_forms.css'), :force => true
FileUrils.rm   File.join(RAILS_ROOT, 'public', 'images', 'icons', 'help.gif'), :force => true

