require_relative 'helper'
require 'fluent/test/driver/parser'
require 'fluent/plugin/parser_json_in_json'
require 'yajl'

class JsonInJsonParserTest < ::Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @parser = Fluent::Test::Driver::Parser.new(Fluent::Plugin::JSONInJSONParser)
  end

  def test_parse_float_time()
    @parser.configure({})
    @parser.instance.parse('{"time":1362020400,"host":"192.168.0.1","size":777,"method":"PUT","log_json":" {\\"field1\\":\\"field1 value\\",\\"field2\\":40}"}') { |time, record|
      assert_equal(event_time('2013-02-28 12:00:00 +0900').to_f, time.to_f)
      assert_equal({
                     'host'   => '192.168.0.1',
                     'size'   => 777,
                     'method' => 'PUT',
                     'field1' => 'field1 value',
                     'field2' => 40
                   }, record)
    }
    @parser.instance.parse('{"time":1362020400,"host":"192.168.0.1","size":777,"method":"PUT","log_json":"{\\"field1\\":"}') { |time, record|
      assert_equal(event_time('2013-02-28 12:00:00 +0900').to_f, time.to_f)
      assert_equal({
                     'host'   => '192.168.0.1',
                     'size'   => 777,
                     'method' => 'PUT',
                     'log_json' => '{"field1":'
                   }, record)
    }
    @parser.instance.parse('{"time":1362020400,"host":"192.168.0.1","size":777,"method":"PUT","log_json":"[\\"val1\\",\\"val2\\"]"') { |time, record|
      assert_equal(event_time('2013-02-28 12:00:00 +0900').to_f, time.to_f)
      assert_equal({
                     'host'   => '192.168.0.1',
                     'size'   => 777,
                     'method' => 'PUT',
                     'log_json' => ['val1', 'val2']
                   }, record)
    }
  end

  def test_parse_string_time()
    @parser.configure('time_format' => '%Y-%m-%dT%H:%M:%S.%NZ', 'keep_time_key' => 'true')
    @parser.instance.parse('{"log":"2018-06-26 13:20:44.075  INFO --- [pool-8-thread-3] outgoing","stream":"stdout","time":"2018-06-26T13:20:44.076022960Z"}') { |time, record|
      assert_equal(event_time('2018-06-26 13:20:44.076022960').to_f, time.to_f)
      assert_equal({
                    'log'=>'2018-06-26 13:20:44.075  INFO --- [pool-8-thread-3] outgoing',
                    'stream'=>'stdout',
                    'time'=>'2018-06-26T13:20:44.076022960Z'
                   }, record)
    }
  end

  def test_yajl_load()
    @parser.configure({})
    @parser.instance.parse('{ "log": " [ msg ] messoge  [ k ]", "stream": "stdout"}') { |time, record|
      assert_equal({
        'log'=> ' [ msg ] messoge  [ k ]',
        'stream'=>'stdout',
      }, record)
    }
    # Yajl.load('["kek":1}')
  end

end
