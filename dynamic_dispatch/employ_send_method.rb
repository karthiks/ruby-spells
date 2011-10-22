#! ruby employ_send_method.rb

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
t.send(:my_freakin_instance_method)
t.send("my_freakin_instance_method")

Test.my_freakin_class_method
Test.send(:my_freakin_class_method)
Test.send("my_freakin_class_method")
