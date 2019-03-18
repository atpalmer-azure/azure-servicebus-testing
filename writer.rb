require 'azure'

MAX_VALUE = 1000

Azure.configure do |config|
  config.sb_namespace = ENV['SERVICEBUS_NAMESPACE']
  config.sb_sas_key_name = ENV['SERVICEBUS_SAS_KEY_NAME']
  config.sb_sas_key = ENV['SERVICEBUS_SAS_KEY_VALUE']
end

service = Azure::ServiceBus::ServiceBusService.new(
  "https://#{Azure.sb_namespace}.servicebus.windows.net/",
  :signer => Azure::ServiceBus::Auth::SharedAccessSigner.new
)

1.upto(MAX_VALUE).each do |n|
  service.send_queue_message('queue1', "Item #{n}")
end

loop do
  print "Message Count: ", service.get_queue('queue1').message_count, "\n"
  print "Message: "
  message = gets.chomp
  service.send_queue_message('queue1', message)
end
