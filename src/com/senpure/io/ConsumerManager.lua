ConsumerManager = {
    requestId = 1;

}

function ConsumerManager:nextRequestId()
    -- lua 是单线程?
    local requestId = ConsumerManager.requestId + 1;
    if (requestId >= 2147483647) then
        requestId = 1;
    end
    ConsumerManager.requestId = requestId;
    return requestId;
end

function ConsumerManager:sendMessage(message)
    --获取c#的buffer c#在调用回来

    CShapeSendMessage(message);
end

function ConsumerManager:CShapeCallEncodeMessage(buf, message)
    local length = message:getSerializedSize(buf);
    buf:EnsureWritable(length + 12);
    buf:WriteSFixed32(length + 8);
    buf:WriteSFixed32(0);
    buf:WriteSFixed32(message.id);
    message:write(buf);
end

function ConsumerManager:CShapeCallDecodeMessage(buf, endIndex)
    local requestId = buf:ReadSFixed32();
    local messageId = buf:ReadSFixed32();
    local message = MSG.CShapeTestMessage:new();
    message:read(buf, endIndex);

end