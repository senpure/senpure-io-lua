MSG = MSG or {}

MSG.CShapeTestMessage = {
    id = 1000205;
    value32 = 2;
    value64 = 4;
    serializedSize = -1;
}
function MSG.CShapeTestMessage:new ()
    local o = {}
    self.__index = self
    setmetatable(o, self)
    return o
end

function MSG.CShapeTestMessage:read(buf, endIndex)
    local switch = {
        [9] = function()
            self.value32 = buf:ReadSFixed32();
        end,
        [18] = function()
            self.value64 = buf:ReadSFixed64();
        end
    }
    while (true) do
        local tag = buf:ReadTag(endIndex);
        if (tag == 0) then
            return ;
        else
            local case = switch[tag];
            if (case) then
                case();
            else
                buf:Skip(tag);
            end
        end
    end
end
function MSG.CShapeTestMessage:write(buf)

    buf:WriteSFixed32(9, self.value32);
    buf:WriteSFixed64(18, self.value64);
end
function MSG.CShapeTestMessage:getSerializedSize(buf)
    local size = self.serializedSize;

    if (size > -1) then
        return size;
    end
    size = 0;
    size = size + buf:ComputeSFixed32Size(1, self.value32);
    size = size + buf:ComputeSFixed64Size(1, self.value64);
    serializedSize = size;
    return size;
end


