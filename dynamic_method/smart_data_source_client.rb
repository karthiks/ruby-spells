#! ruby smart_data_source_client.rb

require File.join(File.expand_path(File.dirname(__FILE__)), 'data_source')

class SmartDataSourceClient

  DataSource.public_instance_methods(false).each do |meth|
    puts "Defining instance method, :#{meth} for class #{self}"
    class_eval do
      define_method meth do 
        @data_source.send meth.to_sym
      end 
    end
  end

  def initialize data_source
    @data_source = data_source
    puts "Public instance methods for this object #{self} are: #{self.public_methods(false).sort}"
  end

end

ds = DataSource.new

puts "-"*20 + "INSTANTIATING FIRST SMART CLIENT" + "-"*20
smart_client = SmartDataSourceClient.new ds
smart_client.my_freakin_method_1
smart_client.my_freakin_method_N
puts ""

puts "-"*20 + "INSTANTIATING SECOND SMART CLIENT" + "-"*20
smart_client_2 = SmartDataSourceClient.new ds

=begin
#Output:
=[ruby-spells-and-meta-programming-techniques(master)]$ ruby dynamic_method/smart_data_source_client.rb 
Defining instance method, :my_freakin_method_1 for class SmartDataSourceClient
Defining instance method, :my_freakin_method_2 for class SmartDataSourceClient
Defining instance method, :my_freakin_method_3 for class SmartDataSourceClient
Defining instance method, :my_freakin_method_N for class SmartDataSourceClient
--------------------INSTANTIATING FIRST SMART CLIENT--------------------
Public instance methods for this object #<SmartDataSourceClient:0x80f67cc> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3, :my_freakin_method_N]
In my_freakin_method_1
In my_freakin_method_N

--------------------INSTANTIATING SECOND SMART CLIENT--------------------
Public instance methods for this object #<SmartDataSourceClient:0x80f654c> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3, :my_freakin_method_N]
end

=begin
#Lesson:
Pros:
-----
1. On observing the output it can be learnt that the methods gets defined on the SmartDataSourceClient class so that all its instances need not define it all again. 
   This is an optimization, to save memory and performance time. 
2. This is better than the previous commit in that the instance methods for the class are defined when the class is first loaded.

Cons:
3. However, this technique cannot be used in cases where we do not have a way to figure out all the public instance methods of the source class at a time when the class is first loaded.
=end
