# frozen_string_literal: true

channel = Core::RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue("auth", durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)

  result = Auth::Sessions::Fetch.new.call(payload["token"])
  reply_payload = if result.success?
                    { status: "success", user_id: result.value!.user_id }
                  else
                    { status: "unauthorized" }
                  end
  exchange.publish(
    reply_payload.to_json,
    routing_key: properties.reply_to,
    correlation_id: properties.correlation_id
  )

  channel.ack(delivery_info.delivery_tag)
end
