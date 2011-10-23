#! ruby smart_data_source_client.rb

require File.join(File.expand_path(File.dirname(__FILE__)), 'data_source')

class SmartDataSourceClient

  def initialize data_source
    obj = self
    puts "#{obj} is being instantiated..."

    @data_source = data_source

    ref = self.class

    data_source.public_methods(false).each do |meth|
      ref.class_eval do
        puts "Know what? Instance method #{meth}, is going to be defined for all instances of #{self}"
        define_method meth do 
          data_source.send "#{meth}"
        end 
      end unless self.respond_to?(meth.to_sym)
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
#<SmartDataSourceClient:0x84a8654> is being instantiated...
Know what? Instance method my_freakin_method_1, is going to be defined for all instances of SmartDataSourceClient
public methods defined in SmartDataSourceClient are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x84a8654> are: [:my_freakin_method_1]

Know what? Instance method my_freakin_method_2, is going to be defined for all instances of SmartDataSourceClient
public methods defined in SmartDataSourceClient are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x84a8654> are: [:my_freakin_method_1, :my_freakin_method_2]

Know what? Instance method my_freakin_method_3, is going to be defined for all instances of SmartDataSourceClient
public methods defined in SmartDataSourceClient are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x84a8654> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3]

Know what? Instance method my_freakin_method_N, is going to be defined for all instances of SmartDataSourceClient
public methods defined in SmartDataSourceClient are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x84a8654> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3, :my_freakin_method_N]

In my_freakin_method_1
In my_freakin_method_N

--------------------INSTANTIATING SECOND SMART CLIENT--------------------
#<SmartDataSourceClient:0x84a7ca4> is being instantiated...
public methods defined in SmartDataSourceClient are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x84a7ca4> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3, :my_freakin_method_N]

public methods defined in SmartDataSourceClient are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x84a7ca4> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3, :my_freakin_method_N]

public methods defined in SmartDataSourceClient are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x84a7ca4> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3, :my_freakin_method_N]

public methods defined in SmartDataSourceClient are: [:allocate, :new, :superclass]
public methods defined in #<SmartDataSourceClient:0x84a7ca4> are: [:my_freakin_method_1, :my_freakin_method_2, :my_freakin_method_3, :my_freakin_method_N]
=end

=begin
#Lesson:
1. On observing the output it can be learnt that the methods gets defined on the SmartDataSourceClient class so that all its instances need not define it all again. This is an optimization, to save memory and performance time. 
=end
