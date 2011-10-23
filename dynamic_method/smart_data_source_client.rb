#! ruby smart_data_source_client.rb

require File.join(File.expand_path(File.dirname(__FILE__)), 'data_source')

class SmartDataSourceClient

  def initialize data_source
    @data_source = data_source
    data_source.public_methods(false).each do |meth|
      ref = (class << self; puts "'self' inside class extension definition --> #{self}"; self; end)
      ref.class_eval do
        define_method meth do 
          data_source.send "#{meth}"
        end 
      end
      puts "public methods defined in #{ref} are: #{ref.public_methods(false)}"
      puts "public methods defined in #{self} are: #{self.public_methods(false)}"
      puts ""
    end
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
[ruby-spells-and-meta-programming-techniques(master)]$ ruby dynamic_method/smart_data_source_client.rb 
--------------------INSTANTIATING FIRST SMART CLIENT--------------------
'self' inside class extension definition --> #<Class:#<SmartDataSourceClient:0x9869918>>
public methods defined in #<Class:#<SmartDataSourceClient:0x9869918>> are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x9869918> are: [:my_freakin_method_1]

'self' inside class extension definition --> #<Class:#<SmartDataSourceClient:0x9869918>>
public methods defined in #<Class:#<SmartDataSourceClient:0x9869918>> are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x9869918> are: [:my_freakin_method_1, :my_freakin_method_2]

'self' inside class extension definition --> #<Class:#<SmartDataSourceClient:0x9869918>>
public methods defined in #<Class:#<SmartDataSourceClient:0x9869918>> are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x9869918> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3]

'self' inside class extension definition --> #<Class:#<SmartDataSourceClient:0x9869918>>
public methods defined in #<Class:#<SmartDataSourceClient:0x9869918>> are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x9869918> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3, :my_freakin_method_N]

In my_freakin_method_1
In my_freakin_method_N

--------------------INSTANTIATING SECOND SMART CLIENT--------------------
'self' inside class extension definition --> #<Class:#<SmartDataSourceClient:0x9868f40>>
public methods defined in #<Class:#<SmartDataSourceClient:0x9868f40>> are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x9868f40> are: [:my_freakin_method_1]

'self' inside class extension definition --> #<Class:#<SmartDataSourceClient:0x9868f40>>
public methods defined in #<Class:#<SmartDataSourceClient:0x9868f40>> are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x9868f40> are: [:my_freakin_method_1, :my_freakin_method_2]

'self' inside class extension definition --> #<Class:#<SmartDataSourceClient:0x9868f40>>
public methods defined in #<Class:#<SmartDataSourceClient:0x9868f40>> are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x9868f40> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3]

'self' inside class extension definition --> #<Class:#<SmartDataSourceClient:0x9868f40>>
public methods defined in #<Class:#<SmartDataSourceClient:0x9868f40>> are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x9868f40> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3, :my_freakin_method_N]
=end

=begin
#Lesson:
1. On observing the output it can be learnt that the methods gets defined on the Eigen/Ghost class of the instances being created. Can this be optimized, to save memory and performance time? That is going to be our next exercise! 
=end
