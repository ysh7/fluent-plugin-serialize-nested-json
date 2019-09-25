require 'fluent/parser'
require 'yajl'

module Fluent
  module Plugin
    class SerializeJSONParser < Parser
      Plugin.register_parser('serialize_nested_json', self)

      config_set_default :time_key, 'time'
      config_set_default :time_type, :float

      def configure(conf)
        if conf.has_key?('time_format')
          conf['time_type'] ||= 'string'
        end

        super
      end

      def parse(text)
        record = Yajl.load(text)

        values = Hash.new

        record.each do |k, v|
          if v.is_a?(Hash) || v.is_a?(Array)
            begin
              values[k] = Yajl::Encoder.encode(v)
              record.delete k
            rescue Exception => e
              # continue
            end
          end
        end
        record.merge!(values)

        time, record = convert_values(parse_time(record), record)

        yield time, record
      rescue Yajl::ParseError
        yield nil, nil
      end
    end
  end
end
