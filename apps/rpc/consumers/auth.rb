# frozen_string_literal: true

logger = Core::Logger.instance
channel = Core::RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue("auth", durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  Thread.current[:request_id] = properties.headers["request_id"]
  payload = JSON(payload)

  result = Auth::Sessions::Fetch.new.call(payload["token"])
  if result.success?
    reply_payload = { status: "success", user_id: result.value!.user_id }
    log_info = { status: "success", details: { user_id: result.value!.user_id } }
  else
    reply_payload = { status: "unauthorized" }
    log_info = { status: "failure" }
  end
  exchange.publish(
    reply_payload.to_json,
    routing_key: properties.reply_to,
    correlation_id: properties.correlation_id
  )

  channel.ack(delivery_info.delivery_tag)
  logger.info("auth", **log_info)
end
