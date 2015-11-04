UpdateTopicMutation = GraphQL::Relay::Mutation.define do
  name "UpdateTopic"

  input_field :channelID, !types.ID
  input_field :topic, !types.String

  return_field :message, !MessageType
  return_field :channel, !ChannelType

  resolve -> (args, ctx) {
    topic_text = args[:topic]

    channel = NodeIdentification.object_from_id(args[:channelID])
    channel.update(topic: topic_text)
    author = User.find(6)
    message_text = "#{author.nickname} set the topic to '#{topic_text}'"
    message = channel.messages.create(text: message_text, author: author)
    { message: message, channel: channel }
  }
end
