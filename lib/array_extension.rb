
# Extend Array so we can easily add an enter option.
class Array
	
	class SelectDummy
		def initialize(value)
			@value = value
		end
		def id
			'enter_new_value'
		end
		def method_missing(*args)
			@value
		end
	end
	
	# 
	def add_enter_option
		self.unshift(SelectDummy.new('neue Eingabe...'))
	end
	
end
