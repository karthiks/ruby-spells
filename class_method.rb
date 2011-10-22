#! ruby class_method.rb

class Test
  def self.my_freakin_class_method
    puts "In class method"
  end

  def my_freakin_instance_method
    puts "In instance method"
  end
end

t = Test.new
t.my_freakin_instance_method

Test.my_freakin_class_method  # is the right and only way you call the class method. Receiver has to be the Class object.
t.my_freakin_class_method
