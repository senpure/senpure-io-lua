ConsumerDecoder = {}

function ConsumerDecoder:decode(buffer)
    local requestId = buffer:ReadInt();
    local messageId = buffer:ReadInt();
    local value = buffer:ReadLong()

    print("value="..value)
end