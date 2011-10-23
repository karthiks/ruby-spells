#! ruby smart_data_source_client.rb

require File.join(File.expand_path(File.dirname(__FILE__)), 'data_source')

class SmartDataSourceClient

  def initialize data_source
    @data_source = data_source
    data_source.public_methods(false).each do |meth|
      (class << self; self; end).class_eval do
        define_method meth do 
          data_source.send "#{meth}"
        end 
      end
    end
  end

end

ds = DataSource.new
smart_client = SmartDataSourceClient.new ds
smart_client.my_freakin_method_1
smart_client.my_freakin_method_N


#Output:
#[ruby-spells-and-meta-programming-techniques(master)]$ ruby dynamic_method/smart_data_source_client.rb 
#In my_freakin_method_1
#In my_freakin_method_N
