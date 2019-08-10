ConsumerStart = {}

function ConsumerStart:start()
   local msg = MSG.CShapeTestMessage:new();
    msg.value32=10;
    msg.value64=100;

ConsumerManager:sendMessage(msg)

end
