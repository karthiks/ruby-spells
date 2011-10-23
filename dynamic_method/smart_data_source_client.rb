#! ruby smart_data_source_client.rb

require File.join(File.expand_path(File.dirname(__FILE__)), 'data_source')

class SmartDataSourceClient

  def initialize data_source
    @data_source = data_source
    [:method_1, :method_2, :method_N].each do |meth|
      (class << self; self; end).class_eval do
        define_method meth do |*args|
          data_source.send "my_freakin_#{meth}", *args
        end 
      end
    end
  end

end

ds = DataSource.new
smart_client = SmartDataSourceClient.new ds
smart_client.method_1
smart_client.method_N
smart_client.no_such_method


#Output:
#[ruby-spells-and-meta-programming-techniques(master)]$ ruby dynamic_method/smart_data_source_client.rb 
#In my_freakin_method_1
#In my_freakin_method_N
#dynamic_method/smart_data_source_client.rb:24:in `<main>': undefined method `no_such_method' for #<SmartDataSourceClient:0x9b042a4> (NoMethodError)

