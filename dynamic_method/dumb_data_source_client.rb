#! ruby dumb_data_source_client.rb

require File.expand_path File.join(File.dirname(__FILE__), 'data_source')

class DumbDataSourceClient

  def initialize(data_source)
    @data_source = data_source
  end

  def method_1
    @data_source.my_freakin_method_1
  end

  def method_2
    @data_source.my_freakin_method_2
  end

  def method_3
    @data_source.my_freakin_method_3
  end

  def method_N
    @data_source.my_freakin_method_N
  end

end

ds = DataSource.new

dumb_client = DumbDataSourceClient.new ds
dumb_client.method_1
dumb_client.method_N
