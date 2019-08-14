ConsumerCallBack = {
    requestId = 0;
    --lua 获取到秒数?
    timeOut = 5;
    callBack = nil;

}

ConsumerManager = {
    requestId = 1,
    _message_decoder = {},
    _message_handler = {},
    _message_callBack = {}
}

function ConsumerManager.regMessageDecoder(_id, _clazz, _target)
    if ConsumerManager._message_decoder[_id] then
        assert(false, "\n_id [" .. _id .. " ] duplicate exist decoder" .. ConsumerManager._message_decoder[_id .. "_target"]
                .. "  ||  new decoder" .. _target)
    end
    print("reg decoder " .. _id .. " to decoding " .. _target)
    ConsumerManager._message_decoder[_id] = _clazz
    ConsumerManager._message_decoder[_id .. "_target"] = _target
end
function ConsumerManager.regMessageHandler(_id, _fun, _target)
    if ConsumerManager._message_handler[_id] then
        assert(false, "\n_id [" .. _id .. " ]  duplicate exist handler" .. ConsumerManager._message_handler[_id .. "_target"]
                .. "  ||  new handler " .. _target)
    end
    print("reg handler " .. _id .. " to handling " .. _target)
    ConsumerManager._message_handler[_id] = _fun
    ConsumerManager._message_handler[_id .. "_target"] = _target
end
function ConsumerManager.nextRequestId()
    -- lua 是单线程?
    local requestId = ConsumerManager.requestId + 1;
    if (requestId >= 2147483647) then
        requestId = 1;
    end
    ConsumerManager.requestId = requestId;
    return requestId;
end

function ConsumerManager.sendMessage(message)
    --获取c#的buffer c#在调用回来

    CShapeSendMessage(message);
end

function ConsumerManager.CShapeCallEncodeMessage(buf, message)
    local length = message:getSerializedSize(buf);
    --requestId = 0 size = 1;
    local headLength = buf:ComputeVar32SizeNoTag(message.messageId) + 1;
    local packageLength = headLength + length;
    buf:EnsureWritable(buf:ComputeVar32SizeNoTag(packageLength) + packageLength);
    buf:WriteVar32(packageLength);
    buf:WriteVar32(0);
    buf:WriteVar32(message.messageId);
    message:write(buf);
end

function ConsumerManager.CShapeCallDecodeMessage(buf, endIndex)
    local requestId = buf:ReadVar32();
    local messageId = buf:ReadVar32();
    local decoder = ConsumerManager._message_decoder[messageId];
    if decoder == nil then
        --这里要求buf,是一个单独的消息不影响下一个buf
        print(messageId .. "has not decoder")
        return
    end
    local message = decoder.getEmptyMessage();
    message:read(buf, endIndex);
    print(message:toString());
    --先不出来callback
    if requestId > 0 then
        local callBack = ConsumerManager._message_callBack[requestId];
        if (callBack) then
        end
    else
        local handler = ConsumerManager._message_handler[messageId]
        if (handler) then
            handler(message);
        else
            print(ConsumerManager._message_decoder[messageId .. "_target"] .. " has not handler");
        end
    end

end