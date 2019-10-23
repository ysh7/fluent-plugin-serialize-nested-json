# fluent-plugin-serialize-nested-json
 [![Gem Version](https://badge.fury.io/rb/fluent-plugin-serialize-nested-json.svg)](https://badge.fury.io/rb/fluent-plugin-serialize-nested-json)

This fluentd parser plugin serializes nested JSON objects in JSON log lines, basically it exactly 
does reverse of [fluent-plugin-json-in-json](https://github.com/alikhil/fluent-plugin-json-in-json).

For example,
``{"ref": {"foo": "bar"}}``, the log record will be parsed into ``{:ref => "{\"foo\": \"bar\"}"}``.

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-serialize-nested-json'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-serialize-nested-json


## Usage

```
<source>
  type tail
  path /var/log/app/*.json
  pos_file /var/log/fluentd.pos
  time_format %Y-%m-%dT%H:%M:%S
  tag fluent.*
  format serialize_nested_json
  read_from_head true
</source>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
