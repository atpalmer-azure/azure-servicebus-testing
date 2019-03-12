# Azure Service Bus Testing

## Configuration

Scripts require the following environment variables:
```
SERVICEBUS_NAMESPACE=<...>
SERVICEBUS_SAS_KEY_NAME=<...>
SERVICEBUS_SAS_KEY_VALUE=<...>
```

## Scripts

* `reader.rb`: Reads messages from service bus queue. Expects sequentially-numbered queue items.
* `writer.rb`: Writes messages to service bus queue. Generates sequentially-numbered queue items.
