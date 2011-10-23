#! ruby dumb_data_source_client.rb

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
