require 'azure'

Azure.configure do |config|
  config.sb_namespace = ENV['SERVICEBUS_NAMESPACE']
  config.sb_sas_key_name = ENV['SERVICEBUS_SAS_KEY_NAME']
  config.sb_sas_key = ENV['SERVICEBUS_SAS_KEY_VALUE']
end

service = Azure::ServiceBus::ServiceBusService.new(
  "https://#{Azure.sb_namespace}.servicebus.windows.net/",
  :signer => Azure::ServiceBus::Auth::SharedAccessSigner.new
)

last = nil
loop do
  print "Message Count: ", service.get_queue('queue1').message_count, "\n"
  received = service.receive_queue_message('queue1')
  puts received.body

  match = /^Item (?<item>[0-9]+)$/.match(received.body)
  curr = Integer(match[:item])
  raise "Expected: #{last + 1}; Got: #{curr}" if last && last + 1 != curr
  last = curr

  service.delete_queue_message(received)
end
