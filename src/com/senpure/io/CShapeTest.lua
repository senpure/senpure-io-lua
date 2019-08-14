--[[
author    senpure
version   2019-8-14 14:28:59
--]]

Data = Data or {}

--[[
Echo中的一个enum
--]]
Data.EchoEnum = {
    --[Comment]
    X = 1,
    --[Comment]
    Y = 2,
    UNKNOWN = -1,
    echoEnumValues = {
        [1] = 1,
        [2] = 2
    },
    echoEnumStr = {
        [1] = "X",
        [2] = "Y"
    },
    checkReadValue = function(value)
        local v = Data.EchoEnum.echoEnumValues[value]
        if v then
            return v
        else
            return -1;
        end
    end,
    valueToStr = function(value)
        local v = Data.EchoEnum.echoEnumStr[value]
        if v then
            return v
        else
            return "UNKNOWN";
        end
    end
}

--[[
    Echo中的一个bean
--]]
Data.EchoBean = {
    --[Comment]
    --类型:int
    value = 0;
    serializedSize = -1;
    --格式化时统一字段长度
    _filedPad = 5 ;
}

--Data.EchoBean构造方法
function Data.EchoBean:new()
    local echoBean = setmetatable({}, {__index=self}) ;
    --[Comment]
    --类型:int
    echoBean.value = 0;
    serializedSize = -1;
    return echoBean;
end

--Data.EchoBean写入字节缓存
function Data.EchoBean:write(buf)
    self:getSerializedSize(buf);
    buf:WriteVar32(8, self.value);
end

--Data.EchoBean读取字节缓存
function Data.EchoBean:read(buf,endIndex)
    local switch = {
        -- 1 << 3 | 0
        [8] = function ()
            self.value = buf:ReadVar32();
        end
    }
    while(true) do
        local tag = buf:ReadTag(endIndex);
        if(tag == 0) then
            return;
        else
            local case = switch[tag];
            if(case) then
                case();
            else
                buf:Skip(tag);
            end
        end
    end
end

--Data.EchoBean计算序列化大小
function Data.EchoBean:getSerializedSize(buf)
    local size = self.serializedSize;
    if (size > -1) then
        return size;
    end
    size = 0;
    -- tag size 已经完成了计算 8
    size = size + buf:ComputeVar32Size(1, self.value);
    self.serializedSize = size ;
    return size ;
end

--Data.EchoBean格式化字符串
function Data.EchoBean:toString(_indent)
    _indent = _indent or ""
    local _str = ""
    _str = _str .. "EchoBean" .. "{"
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("value",self._filedPad) .. " = " .. self.value
    _str =_str .. "\n"
    _str = _str .. _indent .. "}"
    return _str
end

Data.Echo = {
    --[Comment]
    --类型:booleanbooleanValue
    booleanValue = false;
    --[Comment]
    --list:booleanbooleanValues
    booleanValues = nil;
    --[Comment]
    --类型:int    intValue
    intValue = 0;
    --[Comment]
    --list:int    intValues
    intValues = nil;
    --[Comment]
    --类型:long   longValue
    longValue = 0;
    --[Comment]
    --list:long   longValues
    longValues = nil;
    --[Comment]
    --类型:int    sintValue
    sintValue = 0;
    --[Comment]
    --list:int    sintValues
    sintValues = nil;
    --[Comment]
    --类型:long   slongValue
    slongValue = 0;
    --[Comment]
    --list:long   slongValues
    slongValues = nil;
    --[Comment]
    --类型:float  floatValue
    floatValue = 0;
    --[Comment]
    --list:float  floatValues
    floatValues = nil;
    --[Comment]
    --类型:double doubleValue
    doubleValue = 0;
    --[Comment]
    --list:double doubleValues
    doubleValues = nil;
    --[Comment]
    --类型:int    sfixed32Value
    sfixed32Value = 0;
    --[Comment]
    --list:int    sfixed32Values
    sfixed32Values = nil;
    --[Comment]
    --类型:long   sfixed64Value
    sfixed64Value = 0;
    --[Comment]
    --list:long   sfixed64Values
    sfixed64Values = nil;
    --[Comment]
    --类型:String stringValue
    stringValue = "";
    --[Comment]
    --list:String stringValues
    stringValues = nil;
    --[Comment]
    --类型:Data.EchoBean beanValue
    beanValue = nil ;
    --[Comment]
    --list:Data.EchoBean beanValues
    beanValues = nil;
    --[Comment]
    --类型:Data.EchoEnum enumValue
    enumValue= Data.EchoEnum.X;
    --[Comment]
    --list:Data.EchoEnum enumValues
    enumValues = nil;
    --[Comment]
    --类型:boolean
    booleanValue2 = false;
    --[Comment]
    --list:boolean
    booleanValues2 = nil;
    --[Comment]
    --类型:int
    intValue2 = 0;
    --[Comment]
    --list:int
    intValues2 = nil;
    --[Comment]
    --类型:long
    longValue2 = 0;
    --[Comment]
    --list:long
    longValues2 = nil;
    --[Comment]
    --类型:int
    sintValue2 = 0;
    --[Comment]
    --list:int
    sintValues2 = nil;
    --[Comment]
    --类型:long
    slongValue2 = 0;
    --[Comment]
    --list:long
    slongValues2 = nil;
    --[Comment]
    --类型:float
    floatValue2 = 0;
    --[Comment]
    --list:float
    floatValues2 = nil;
    --[Comment]
    --类型:double
    doubleValue2 = 0;
    --[Comment]
    --list:double
    doubleValues2 = nil;
    --[Comment]
    --类型:int
    sfixed32Value2 = 0;
    --[Comment]
    --list:int
    sfixed32Values2 = nil;
    --[Comment]
    --类型:long
    sfixed64Value2 = 0;
    --[Comment]
    --list:long
    sfixed64Values2 = nil;
    --[Comment]
    --类型:String
    stringValue2 = "";
    --[Comment]
    --list:String
    stringValues2 = nil;
    --[Comment]
    --类型:Data.EchoBean
    beanValue2 = nil ;
    --[Comment]
    --list:Data.EchoBean
    beanValues2 = nil;
    --[Comment]
    --类型:Data.EchoEnum
    enumValue2= Data.EchoEnum.X;
    --[Comment]
    --list:Data.EchoEnum
    enumValues2 = nil;
    serializedSize = -1;
    booleanValuesSerializedSize = 0;
    intValuesSerializedSize = 0;
    longValuesSerializedSize = 0;
    sintValuesSerializedSize = 0;
    slongValuesSerializedSize = 0;
    floatValuesSerializedSize = 0;
    doubleValuesSerializedSize = 0;
    sfixed32ValuesSerializedSize = 0;
    sfixed64ValuesSerializedSize = 0;
    enumValuesSerializedSize = 0;
    booleanValues2SerializedSize = 0;
    intValues2SerializedSize = 0;
    longValues2SerializedSize = 0;
    sintValues2SerializedSize = 0;
    slongValues2SerializedSize = 0;
    floatValues2SerializedSize = 0;
    doubleValues2SerializedSize = 0;
    sfixed32Values2SerializedSize = 0;
    sfixed64Values2SerializedSize = 0;
    enumValues2SerializedSize = 0;
    --缩进15 + 3 = 18 个空格
    _next_indent = "                  ";
    --格式化时统一字段长度
    _filedPad = 15 ;
}

--Data.Echo构造方法
function Data.Echo:new()
    local echo = setmetatable({}, {__index=self}) ;
    --[Comment]
    --类型:booleanbooleanValue
    echo.booleanValue = false;
    --[Comment]
    --list:booleanbooleanValues
    echo.booleanValues = nil;
    --[Comment]
    --类型:int    intValue
    echo.intValue = 0;
    --[Comment]
    --list:int    intValues
    echo.intValues = nil;
    --[Comment]
    --类型:long   longValue
    echo.longValue = 0;
    --[Comment]
    --list:long   longValues
    echo.longValues = nil;
    --[Comment]
    --类型:int    sintValue
    echo.sintValue = 0;
    --[Comment]
    --list:int    sintValues
    echo.sintValues = nil;
    --[Comment]
    --类型:long   slongValue
    echo.slongValue = 0;
    --[Comment]
    --list:long   slongValues
    echo.slongValues = nil;
    --[Comment]
    --类型:float  floatValue
    echo.floatValue = 0;
    --[Comment]
    --list:float  floatValues
    echo.floatValues = nil;
    --[Comment]
    --类型:double doubleValue
    echo.doubleValue = 0;
    --[Comment]
    --list:double doubleValues
    echo.doubleValues = nil;
    --[Comment]
    --类型:int    sfixed32Value
    echo.sfixed32Value = 0;
    --[Comment]
    --list:int    sfixed32Values
    echo.sfixed32Values = nil;
    --[Comment]
    --类型:long   sfixed64Value
    echo.sfixed64Value = 0;
    --[Comment]
    --list:long   sfixed64Values
    echo.sfixed64Values = nil;
    --[Comment]
    --类型:String stringValue
    echo.stringValue = "";
    --[Comment]
    --list:String stringValues
    echo.stringValues = nil;
    --[Comment]
    --类型:DataEchoBean beanValue
    echo.beanValue = nil ;
    --[Comment]
    --list:DataEchoBean beanValues
    echo.beanValues = nil;
    --[Comment]
    --类型:DataEchoEnum enumValue
    echo.enumValue = Data.EchoEnum.X ;
    --[Comment]
    --list:DataEchoEnum enumValues
    echo.enumValues = nil;
    --[Comment]
    --类型:boolean
    echo.booleanValue2 = false;
    --[Comment]
    --list:boolean
    echo.booleanValues2 = nil;
    --[Comment]
    --类型:int
    echo.intValue2 = 0;
    --[Comment]
    --list:int
    echo.intValues2 = nil;
    --[Comment]
    --类型:long
    echo.longValue2 = 0;
    --[Comment]
    --list:long
    echo.longValues2 = nil;
    --[Comment]
    --类型:int
    echo.sintValue2 = 0;
    --[Comment]
    --list:int
    echo.sintValues2 = nil;
    --[Comment]
    --类型:long
    echo.slongValue2 = 0;
    --[Comment]
    --list:long
    echo.slongValues2 = nil;
    --[Comment]
    --类型:float
    echo.floatValue2 = 0;
    --[Comment]
    --list:float
    echo.floatValues2 = nil;
    --[Comment]
    --类型:double
    echo.doubleValue2 = 0;
    --[Comment]
    --list:double
    echo.doubleValues2 = nil;
    --[Comment]
    --类型:int
    echo.sfixed32Value2 = 0;
    --[Comment]
    --list:int
    echo.sfixed32Values2 = nil;
    --[Comment]
    --类型:long
    echo.sfixed64Value2 = 0;
    --[Comment]
    --list:long
    echo.sfixed64Values2 = nil;
    --[Comment]
    --类型:String
    echo.stringValue2 = "";
    --[Comment]
    --list:String
    echo.stringValues2 = nil;
    --[Comment]
    --类型:DataEchoBean
    echo.beanValue2 = nil ;
    --[Comment]
    --list:DataEchoBean
    echo.beanValues2 = nil;
    --[Comment]
    --类型:DataEchoEnum
    echo.enumValue2 = Data.EchoEnum.X ;
    --[Comment]
    --list:DataEchoEnum
    echo.enumValues2 = nil;
    serializedSize = -1;
    booleanValuesSerializedSize = 0;
    intValuesSerializedSize = 0;
    longValuesSerializedSize = 0;
    sintValuesSerializedSize = 0;
    slongValuesSerializedSize = 0;
    floatValuesSerializedSize = 0;
    doubleValuesSerializedSize = 0;
    sfixed32ValuesSerializedSize = 0;
    sfixed64ValuesSerializedSize = 0;
    enumValuesSerializedSize = 0;
    booleanValues2SerializedSize = 0;
    intValues2SerializedSize = 0;
    longValues2SerializedSize = 0;
    sintValues2SerializedSize = 0;
    slongValues2SerializedSize = 0;
    floatValues2SerializedSize = 0;
    doubleValues2SerializedSize = 0;
    sfixed32Values2SerializedSize = 0;
    sfixed64Values2SerializedSize = 0;
    enumValues2SerializedSize = 0;
    return echo;
end

--Data.Echo写入字节缓存
function Data.Echo:write(buf)
    self:getSerializedSize(buf);
    --booleanValue
    buf:WriteBoolean(8, self.booleanValue);
    --booleanValues
    if self.booleanValues then
        local booleanValues_len = #self.booleanValues;
        if booleanValues_len > 0 then
            buf:WriteVar32(19);
            buf:WriteVar32(self.booleanValuesSerializedSize);
            for i = 1, booleanValues_len do
                buf:WriteBoolean(self.booleanValues[i]);
            end
        end
    end
    --intValue
    buf:WriteVar32(24, self.intValue);
    --intValues
    if self.intValues then
        local intValues_len = #self.intValues;
        if intValues_len > 0 then
            buf:WriteVar32(35);
            buf:WriteVar32(self.intValuesSerializedSize);
            for i = 1, intValues_len do
                buf:WriteVar32(self.intValues[i]);
            end
        end
    end
    --longValue
    buf:WriteVar64(40, self.longValue);
    --longValues
    if self.longValues then
        local longValues_len = #self.longValues;
        if longValues_len > 0 then
            buf:WriteVar32(51);
            buf:WriteVar32(self.longValuesSerializedSize);
            for i = 1, longValues_len do
                buf:WriteVar64(self.longValues[i]);
            end
        end
    end
    --sintValue
    buf:WriteSInt(56, self.sintValue);
    --sintValues
    if self.sintValues then
        local sintValues_len = #self.sintValues;
        if sintValues_len > 0 then
            buf:WriteVar32(67);
            buf:WriteVar32(self.sintValuesSerializedSize);
            for i = 1, sintValues_len do
                buf:WriteSInt(self.sintValues[i]);
            end
        end
    end
    --slongValue
    buf:WriteSLong(72, self.slongValue);
    --slongValues
    if self.slongValues then
        local slongValues_len = #self.slongValues;
        if slongValues_len > 0 then
            buf:WriteVar32(83);
            buf:WriteVar32(self.slongValuesSerializedSize);
            for i = 1, slongValues_len do
                buf:WriteSLong(self.slongValues[i]);
            end
        end
    end
    --floatValue
    buf:WriteFloat(89, self.floatValue);
    --floatValues
    if self.floatValues then
        local floatValues_len = #self.floatValues;
        if floatValues_len > 0 then
            buf:WriteVar32(99);
            buf:WriteVar32(self.floatValuesSerializedSize);
            for i = 1, floatValues_len do
                buf:WriteFloat(self.floatValues[i]);
            end
        end
    end
    --doubleValue
    buf:WriteDouble(106, self.doubleValue);
    --doubleValues
    if self.doubleValues then
        local doubleValues_len = #self.doubleValues;
        if doubleValues_len > 0 then
            buf:WriteVar32(115);
            buf:WriteVar32(self.doubleValuesSerializedSize);
            for i = 1, doubleValues_len do
                buf:WriteDouble(self.doubleValues[i]);
            end
        end
    end
    --sfixed32Value
    buf:WriteSFixed32(121, self.sfixed32Value);
    --sfixed32Values
    if self.sfixed32Values then
        local sfixed32Values_len = #self.sfixed32Values;
        if sfixed32Values_len > 0 then
            buf:WriteVar32(131);
            buf:WriteVar32(self.sfixed32ValuesSerializedSize);
            for i = 1, sfixed32Values_len do
                buf:WriteSFixed32(self.sfixed32Values[i]);
            end
        end
    end
    --sfixed64Value
    buf:WriteSFixed64(138, self.sfixed64Value);
    --sfixed64Values
    if self.sfixed64Values then
        local sfixed64Values_len = #self.sfixed64Values;
        if sfixed64Values_len > 0 then
            buf:WriteVar32(147);
            buf:WriteVar32(self.sfixed64ValuesSerializedSize);
            for i = 1, sfixed64Values_len do
                buf:WriteSFixed64(self.sfixed64Values[i]);
            end
        end
    end
    --stringValue
    if self.stringValue then
        buf:WriteString(155, self.stringValue);
    end
    --stringValues
    if self.stringValues then
        local stringValues_len = #self.stringValues;
        for i = 1,stringValues_len do
            buf:WriteString(163, self.stringValues[i]);
        end
    end
    --beanValue
    if self.beanValue then
        buf:WriteVar32(171);
        buf:WriteVar32(self.beanValue:getSerializedSize(buf));
        self.beanValue:write(buf);
    end
    --beanValues
    if self.beanValues then
        local beanValues_len = #self.beanValues;
        for i = 1,beanValues_len do
            buf:WriteVar32(179);
            buf:WriteVar32(self.beanValues[i]:getSerializedSize(buf));
            self.beanValues[i]:write(buf);
        end
    end
    --enumValue
    if self.enumValue then
        buf:WriteVar32(187, self.enumValue);
    end
    --enumValues
    if self.enumValues then
        local enumValues_len = #self.enumValues;
        buf:WriteVar32(195);
        buf:WriteVar32(self.enumValuesSerializedSize);
        for i = 1,enumValues_len do
            buf:WriteVar32(self.enumValues[i]);
        end
    end
    buf:WriteBoolean(200, self.booleanValue2);
    if self.booleanValues2 then
        local booleanValues2_len = #self.booleanValues2;
        if booleanValues2_len > 0 then
            buf:WriteVar32(211);
            buf:WriteVar32(self.booleanValues2SerializedSize);
            for i = 1, booleanValues2_len do
                buf:WriteBoolean(self.booleanValues2[i]);
            end
        end
    end
    buf:WriteVar32(216, self.intValue2);
    if self.intValues2 then
        local intValues2_len = #self.intValues2;
        if intValues2_len > 0 then
            buf:WriteVar32(227);
            buf:WriteVar32(self.intValues2SerializedSize);
            for i = 1, intValues2_len do
                buf:WriteVar32(self.intValues2[i]);
            end
        end
    end
    buf:WriteVar64(232, self.longValue2);
    if self.longValues2 then
        local longValues2_len = #self.longValues2;
        if longValues2_len > 0 then
            buf:WriteVar32(243);
            buf:WriteVar32(self.longValues2SerializedSize);
            for i = 1, longValues2_len do
                buf:WriteVar64(self.longValues2[i]);
            end
        end
    end
    buf:WriteSInt(248, self.sintValue2);
    if self.sintValues2 then
        local sintValues2_len = #self.sintValues2;
        if sintValues2_len > 0 then
            buf:WriteVar32(259);
            buf:WriteVar32(self.sintValues2SerializedSize);
            for i = 1, sintValues2_len do
                buf:WriteSInt(self.sintValues2[i]);
            end
        end
    end
    buf:WriteSLong(264, self.slongValue2);
    if self.slongValues2 then
        local slongValues2_len = #self.slongValues2;
        if slongValues2_len > 0 then
            buf:WriteVar32(275);
            buf:WriteVar32(self.slongValues2SerializedSize);
            for i = 1, slongValues2_len do
                buf:WriteSLong(self.slongValues2[i]);
            end
        end
    end
    buf:WriteFloat(281, self.floatValue2);
    if self.floatValues2 then
        local floatValues2_len = #self.floatValues2;
        if floatValues2_len > 0 then
            buf:WriteVar32(291);
            buf:WriteVar32(self.floatValues2SerializedSize);
            for i = 1, floatValues2_len do
                buf:WriteFloat(self.floatValues2[i]);
            end
        end
    end
    buf:WriteDouble(298, self.doubleValue2);
    if self.doubleValues2 then
        local doubleValues2_len = #self.doubleValues2;
        if doubleValues2_len > 0 then
            buf:WriteVar32(307);
            buf:WriteVar32(self.doubleValues2SerializedSize);
            for i = 1, doubleValues2_len do
                buf:WriteDouble(self.doubleValues2[i]);
            end
        end
    end
    buf:WriteSFixed32(313, self.sfixed32Value2);
    if self.sfixed32Values2 then
        local sfixed32Values2_len = #self.sfixed32Values2;
        if sfixed32Values2_len > 0 then
            buf:WriteVar32(323);
            buf:WriteVar32(self.sfixed32Values2SerializedSize);
            for i = 1, sfixed32Values2_len do
                buf:WriteSFixed32(self.sfixed32Values2[i]);
            end
        end
    end
    buf:WriteSFixed64(330, self.sfixed64Value2);
    if self.sfixed64Values2 then
        local sfixed64Values2_len = #self.sfixed64Values2;
        if sfixed64Values2_len > 0 then
            buf:WriteVar32(339);
            buf:WriteVar32(self.sfixed64Values2SerializedSize);
            for i = 1, sfixed64Values2_len do
                buf:WriteSFixed64(self.sfixed64Values2[i]);
            end
        end
    end
    if self.stringValue2 then
        buf:WriteString(347, self.stringValue2);
    end
    if self.stringValues2 then
        local stringValues2_len = #self.stringValues2;
        for i = 1,stringValues2_len do
            buf:WriteString(355, self.stringValues2[i]);
        end
    end
    if self.beanValue2 then
        buf:WriteVar32(363);
        buf:WriteVar32(self.beanValue2:getSerializedSize(buf));
        self.beanValue2:write(buf);
    end
    if self.beanValues2 then
        local beanValues2_len = #self.beanValues2;
        for i = 1,beanValues2_len do
            buf:WriteVar32(371);
            buf:WriteVar32(self.beanValues2[i]:getSerializedSize(buf));
            self.beanValues2[i]:write(buf);
        end
    end
    if self.enumValue2 then
        buf:WriteVar32(379, self.enumValue2);
    end
    if self.enumValues2 then
        local enumValues2_len = #self.enumValues2;
        buf:WriteVar32(387);
        buf:WriteVar32(self.enumValues2SerializedSize);
        for i = 1,enumValues2_len do
            buf:WriteVar32(self.enumValues2[i]);
        end
    end
end

--Data.Echo读取字节缓存
function Data.Echo:read(buf,endIndex)
    local switch = {
        -- booleanValue
        -- 1 << 3 | 0
        [8] = function ()
            self.booleanValue = buf:ReadBoolean();
        end ,
        -- booleanValues
        -- 2 << 3 | 3
        [19] = function ()
            local booleanValuesDataSize = buf:ReadVar32();
            self.booleanValues = {};
            local receiveBooleanValuesDataSize = 0;
            local readBooleanValuesIndex = 1;
            while(receiveBooleanValuesDataSize < booleanValuesDataSize ) do
                local tempBooleanValues = buf:ReadBoolean();
                receiveBooleanValuesDataSize = receiveBooleanValuesDataSize + buf:ComputeBooleanSizeNoTag(tempBooleanValues);
                self.booleanValues[readBooleanValuesIndex] = tempBooleanValues;
                readBooleanValuesIndex = readBooleanValuesIndex + 1;
            end
        end ,
        -- intValue
        -- 3 << 3 | 0
        [24] = function ()
            self.intValue = buf:ReadVar32();
        end ,
        -- intValues
        -- 4 << 3 | 3
        [35] = function ()
            local intValuesDataSize = buf:ReadVar32();
            self.intValues = {};
            local receiveIntValuesDataSize = 0;
            local readIntValuesIndex = 1;
            while(receiveIntValuesDataSize < intValuesDataSize ) do
                local tempIntValues = buf:ReadVar32();
                receiveIntValuesDataSize = receiveIntValuesDataSize + buf:ComputeVar32SizeNoTag(tempIntValues);
                self.intValues[readIntValuesIndex] = tempIntValues;
                readIntValuesIndex = readIntValuesIndex + 1;
            end
        end ,
        -- longValue
        -- 5 << 3 | 0
        [40] = function ()
            self.longValue = buf:ReadVar64();
        end ,
        -- longValues
        -- 6 << 3 | 3
        [51] = function ()
            local longValuesDataSize = buf:ReadVar32();
            self.longValues = {};
            local receiveLongValuesDataSize = 0;
            local readLongValuesIndex = 1;
            while(receiveLongValuesDataSize < longValuesDataSize ) do
                local tempLongValues = buf:ReadVar64();
                receiveLongValuesDataSize = receiveLongValuesDataSize + buf:ComputeVar64SizeNoTag(tempLongValues);
                self.longValues[readLongValuesIndex] = tempLongValues;
                readLongValuesIndex = readLongValuesIndex + 1;
            end
        end ,
        -- sintValue
        -- 7 << 3 | 0
        [56] = function ()
            self.sintValue = buf:ReadSInt();
        end ,
        -- sintValues
        -- 8 << 3 | 3
        [67] = function ()
            local sintValuesDataSize = buf:ReadVar32();
            self.sintValues = {};
            local receiveSintValuesDataSize = 0;
            local readSintValuesIndex = 1;
            while(receiveSintValuesDataSize < sintValuesDataSize ) do
                local tempSintValues = buf:ReadSInt();
                receiveSintValuesDataSize = receiveSintValuesDataSize + buf:ComputeSIntSizeNoTag(tempSintValues);
                self.sintValues[readSintValuesIndex] = tempSintValues;
                readSintValuesIndex = readSintValuesIndex + 1;
            end
        end ,
        -- slongValue
        -- 9 << 3 | 0
        [72] = function ()
            self.slongValue = buf:ReadSLong();
        end ,
        -- slongValues
        -- 10 << 3 | 3
        [83] = function ()
            local slongValuesDataSize = buf:ReadVar32();
            self.slongValues = {};
            local receiveSlongValuesDataSize = 0;
            local readSlongValuesIndex = 1;
            while(receiveSlongValuesDataSize < slongValuesDataSize ) do
                local tempSlongValues = buf:ReadSLong();
                receiveSlongValuesDataSize = receiveSlongValuesDataSize + buf:ComputeSLongSizeNoTag(tempSlongValues);
                self.slongValues[readSlongValuesIndex] = tempSlongValues;
                readSlongValuesIndex = readSlongValuesIndex + 1;
            end
        end ,
        -- floatValue
        -- 11 << 3 | 1
        [89] = function ()
            self.floatValue = buf:ReadFloat();
        end ,
        -- floatValues
        -- 12 << 3 | 3
        [99] = function ()
            local floatValuesDataSize = buf:ReadVar32();
            self.floatValues = {};
            local receiveFloatValuesDataSize = 0;
            local readFloatValuesIndex = 1;
            while(receiveFloatValuesDataSize < floatValuesDataSize ) do
                local tempFloatValues = buf:ReadFloat();
                receiveFloatValuesDataSize = receiveFloatValuesDataSize + buf:ComputeFloatSizeNoTag(tempFloatValues);
                self.floatValues[readFloatValuesIndex] = tempFloatValues;
                readFloatValuesIndex = readFloatValuesIndex + 1;
            end
        end ,
        -- doubleValue
        -- 13 << 3 | 2
        [106] = function ()
            self.doubleValue = buf:ReadDouble();
        end ,
        -- doubleValues
        -- 14 << 3 | 3
        [115] = function ()
            local doubleValuesDataSize = buf:ReadVar32();
            self.doubleValues = {};
            local receiveDoubleValuesDataSize = 0;
            local readDoubleValuesIndex = 1;
            while(receiveDoubleValuesDataSize < doubleValuesDataSize ) do
                local tempDoubleValues = buf:ReadDouble();
                receiveDoubleValuesDataSize = receiveDoubleValuesDataSize + buf:ComputeDoubleSizeNoTag(tempDoubleValues);
                self.doubleValues[readDoubleValuesIndex] = tempDoubleValues;
                readDoubleValuesIndex = readDoubleValuesIndex + 1;
            end
        end ,
        -- sfixed32Value
        -- 15 << 3 | 1
        [121] = function ()
            self.sfixed32Value = buf:ReadSFixed32();
        end ,
        -- sfixed32Values
        -- 16 << 3 | 3
        [131] = function ()
            local sfixed32ValuesDataSize = buf:ReadVar32();
            self.sfixed32Values = {};
            local receiveSfixed32ValuesDataSize = 0;
            local readSfixed32ValuesIndex = 1;
            while(receiveSfixed32ValuesDataSize < sfixed32ValuesDataSize ) do
                local tempSfixed32Values = buf:ReadSFixed32();
                receiveSfixed32ValuesDataSize = receiveSfixed32ValuesDataSize + buf:ComputeSFixed32SizeNoTag(tempSfixed32Values);
                self.sfixed32Values[readSfixed32ValuesIndex] = tempSfixed32Values;
                readSfixed32ValuesIndex = readSfixed32ValuesIndex + 1;
            end
        end ,
        -- sfixed64Value
        -- 17 << 3 | 2
        [138] = function ()
            self.sfixed64Value = buf:ReadSFixed64();
        end ,
        -- sfixed64Values
        -- 18 << 3 | 3
        [147] = function ()
            local sfixed64ValuesDataSize = buf:ReadVar32();
            self.sfixed64Values = {};
            local receiveSfixed64ValuesDataSize = 0;
            local readSfixed64ValuesIndex = 1;
            while(receiveSfixed64ValuesDataSize < sfixed64ValuesDataSize ) do
                local tempSfixed64Values = buf:ReadSFixed64();
                receiveSfixed64ValuesDataSize = receiveSfixed64ValuesDataSize + buf:ComputeSFixed64SizeNoTag(tempSfixed64Values);
                self.sfixed64Values[readSfixed64ValuesIndex] = tempSfixed64Values;
                readSfixed64ValuesIndex = readSfixed64ValuesIndex + 1;
            end
        end ,
        -- stringValue
        -- 19 << 3 | 3
        [155] = function ()
            self.stringValue = buf:ReadString();
        end ,
        -- stringValues
        -- 20 << 3 | 3
        [163] = function ()
            self.stringValues = self.stringValues or {};
            self.readStringValuesIndex = self.readStringValuesIndex or 1;
            self.stringValues[self.readStringValuesIndex] = buf:ReadString();
            self.readStringValuesIndex = self.readStringValuesIndex + 1;
        end ,
        -- beanValue
        -- 21 << 3 | 3
        [171] = function ()
            self.beanValue = Data.EchoBean:new()
            self.beanValue:read(buf,buf:ReadVar32()+buf:ReaderIndex())
        end ,
        -- beanValues
        -- 22 << 3 | 3
        [179] = function ()
            self.beanValues = self.beanValues or {};
            self.readBeanValuesIndex = self.readBeanValuesIndex or 1;
            local tempDataEchoBean = Data.EchoBean:new()
            tempDataEchoBean:read(buf,buf:ReadVar32()+buf:ReaderIndex())
            self.beanValues[self.readBeanValuesIndex]  = tempDataEchoBean;
            self.readBeanValuesIndex  = self.readBeanValuesIndex  + 1;
        end ,
        -- enumValue
        -- 23 << 3 | 3
        [187] = function ()
            self.enumValue=Data.EchoEnum.checkReadValue(buf:ReadVar32());
        end ,
        -- enumValues
        -- 24 << 3 | 3
        [195] = function ()
            local enumValuesDataSize = buf:ReadVar32();
            self.enumValues = {};
            local receiveEnumValuesDataSize = 0;
            local readEnumValuesIndex = 1;
            while(receiveEnumValuesDataSize < enumValuesDataSize ) do
                local tempEnumValues = buf:ReadVar32();
                receiveEnumValuesDataSize = receiveEnumValuesDataSize + buf:ComputeVar32Size(tempEnumValues);
                self.enumValues[readEnumValuesIndex] = Data.EchoEnum.checkReadValue(tempEnumValues);
                readEnumValuesIndex = readEnumValuesIndex + 1;
            end
        end ,
        -- 25 << 3 | 0
        [200] = function ()
            self.booleanValue2 = buf:ReadBoolean();
        end ,
        -- 26 << 3 | 3
        [211] = function ()
            local booleanValues2DataSize = buf:ReadVar32();
            self.booleanValues2 = {};
            local receiveBooleanValues2DataSize = 0;
            local readBooleanValues2Index = 1;
            while(receiveBooleanValues2DataSize < booleanValues2DataSize ) do
                local tempBooleanValues2 = buf:ReadBoolean();
                receiveBooleanValues2DataSize = receiveBooleanValues2DataSize + buf:ComputeBooleanSizeNoTag(tempBooleanValues2);
                self.booleanValues2[readBooleanValues2Index] = tempBooleanValues2;
                readBooleanValues2Index = readBooleanValues2Index + 1;
            end
        end ,
        -- 27 << 3 | 0
        [216] = function ()
            self.intValue2 = buf:ReadVar32();
        end ,
        -- 28 << 3 | 3
        [227] = function ()
            local intValues2DataSize = buf:ReadVar32();
            self.intValues2 = {};
            local receiveIntValues2DataSize = 0;
            local readIntValues2Index = 1;
            while(receiveIntValues2DataSize < intValues2DataSize ) do
                local tempIntValues2 = buf:ReadVar32();
                receiveIntValues2DataSize = receiveIntValues2DataSize + buf:ComputeVar32SizeNoTag(tempIntValues2);
                self.intValues2[readIntValues2Index] = tempIntValues2;
                readIntValues2Index = readIntValues2Index + 1;
            end
        end ,
        -- 29 << 3 | 0
        [232] = function ()
            self.longValue2 = buf:ReadVar64();
        end ,
        -- 30 << 3 | 3
        [243] = function ()
            local longValues2DataSize = buf:ReadVar32();
            self.longValues2 = {};
            local receiveLongValues2DataSize = 0;
            local readLongValues2Index = 1;
            while(receiveLongValues2DataSize < longValues2DataSize ) do
                local tempLongValues2 = buf:ReadVar64();
                receiveLongValues2DataSize = receiveLongValues2DataSize + buf:ComputeVar64SizeNoTag(tempLongValues2);
                self.longValues2[readLongValues2Index] = tempLongValues2;
                readLongValues2Index = readLongValues2Index + 1;
            end
        end ,
        -- 31 << 3 | 0
        [248] = function ()
            self.sintValue2 = buf:ReadSInt();
        end ,
        -- 32 << 3 | 3
        [259] = function ()
            local sintValues2DataSize = buf:ReadVar32();
            self.sintValues2 = {};
            local receiveSintValues2DataSize = 0;
            local readSintValues2Index = 1;
            while(receiveSintValues2DataSize < sintValues2DataSize ) do
                local tempSintValues2 = buf:ReadSInt();
                receiveSintValues2DataSize = receiveSintValues2DataSize + buf:ComputeSIntSizeNoTag(tempSintValues2);
                self.sintValues2[readSintValues2Index] = tempSintValues2;
                readSintValues2Index = readSintValues2Index + 1;
            end
        end ,
        -- 33 << 3 | 0
        [264] = function ()
            self.slongValue2 = buf:ReadSLong();
        end ,
        -- 34 << 3 | 3
        [275] = function ()
            local slongValues2DataSize = buf:ReadVar32();
            self.slongValues2 = {};
            local receiveSlongValues2DataSize = 0;
            local readSlongValues2Index = 1;
            while(receiveSlongValues2DataSize < slongValues2DataSize ) do
                local tempSlongValues2 = buf:ReadSLong();
                receiveSlongValues2DataSize = receiveSlongValues2DataSize + buf:ComputeSLongSizeNoTag(tempSlongValues2);
                self.slongValues2[readSlongValues2Index] = tempSlongValues2;
                readSlongValues2Index = readSlongValues2Index + 1;
            end
        end ,
        -- 35 << 3 | 1
        [281] = function ()
            self.floatValue2 = buf:ReadFloat();
        end ,
        -- 36 << 3 | 3
        [291] = function ()
            local floatValues2DataSize = buf:ReadVar32();
            self.floatValues2 = {};
            local receiveFloatValues2DataSize = 0;
            local readFloatValues2Index = 1;
            while(receiveFloatValues2DataSize < floatValues2DataSize ) do
                local tempFloatValues2 = buf:ReadFloat();
                receiveFloatValues2DataSize = receiveFloatValues2DataSize + buf:ComputeFloatSizeNoTag(tempFloatValues2);
                self.floatValues2[readFloatValues2Index] = tempFloatValues2;
                readFloatValues2Index = readFloatValues2Index + 1;
            end
        end ,
        -- 37 << 3 | 2
        [298] = function ()
            self.doubleValue2 = buf:ReadDouble();
        end ,
        -- 38 << 3 | 3
        [307] = function ()
            local doubleValues2DataSize = buf:ReadVar32();
            self.doubleValues2 = {};
            local receiveDoubleValues2DataSize = 0;
            local readDoubleValues2Index = 1;
            while(receiveDoubleValues2DataSize < doubleValues2DataSize ) do
                local tempDoubleValues2 = buf:ReadDouble();
                receiveDoubleValues2DataSize = receiveDoubleValues2DataSize + buf:ComputeDoubleSizeNoTag(tempDoubleValues2);
                self.doubleValues2[readDoubleValues2Index] = tempDoubleValues2;
                readDoubleValues2Index = readDoubleValues2Index + 1;
            end
        end ,
        -- 39 << 3 | 1
        [313] = function ()
            self.sfixed32Value2 = buf:ReadSFixed32();
        end ,
        -- 40 << 3 | 3
        [323] = function ()
            local sfixed32Values2DataSize = buf:ReadVar32();
            self.sfixed32Values2 = {};
            local receiveSfixed32Values2DataSize = 0;
            local readSfixed32Values2Index = 1;
            while(receiveSfixed32Values2DataSize < sfixed32Values2DataSize ) do
                local tempSfixed32Values2 = buf:ReadSFixed32();
                receiveSfixed32Values2DataSize = receiveSfixed32Values2DataSize + buf:ComputeSFixed32SizeNoTag(tempSfixed32Values2);
                self.sfixed32Values2[readSfixed32Values2Index] = tempSfixed32Values2;
                readSfixed32Values2Index = readSfixed32Values2Index + 1;
            end
        end ,
        -- 41 << 3 | 2
        [330] = function ()
            self.sfixed64Value2 = buf:ReadSFixed64();
        end ,
        -- 42 << 3 | 3
        [339] = function ()
            local sfixed64Values2DataSize = buf:ReadVar32();
            self.sfixed64Values2 = {};
            local receiveSfixed64Values2DataSize = 0;
            local readSfixed64Values2Index = 1;
            while(receiveSfixed64Values2DataSize < sfixed64Values2DataSize ) do
                local tempSfixed64Values2 = buf:ReadSFixed64();
                receiveSfixed64Values2DataSize = receiveSfixed64Values2DataSize + buf:ComputeSFixed64SizeNoTag(tempSfixed64Values2);
                self.sfixed64Values2[readSfixed64Values2Index] = tempSfixed64Values2;
                readSfixed64Values2Index = readSfixed64Values2Index + 1;
            end
        end ,
        -- 43 << 3 | 3
        [347] = function ()
            self.stringValue2 = buf:ReadString();
        end ,
        -- 44 << 3 | 3
        [355] = function ()
            self.stringValues2 = self.stringValues2 or {};
            self.readStringValues2Index = self.readStringValues2Index or 1;
            self.stringValues2[self.readStringValues2Index] = buf:ReadString();
            self.readStringValues2Index = self.readStringValues2Index + 1;
        end ,
        -- 45 << 3 | 3
        [363] = function ()
            self.beanValue2 = Data.EchoBean:new()
            self.beanValue2:read(buf,buf:ReadVar32()+buf:ReaderIndex())
        end ,
        -- 46 << 3 | 3
        [371] = function ()
            self.beanValues2 = self.beanValues2 or {};
            self.readBeanValues2Index = self.readBeanValues2Index or 1;
            local tempDataEchoBean = Data.EchoBean:new()
            tempDataEchoBean:read(buf,buf:ReadVar32()+buf:ReaderIndex())
            self.beanValues2[self.readBeanValues2Index]  = tempDataEchoBean;
            self.readBeanValues2Index  = self.readBeanValues2Index  + 1;
        end ,
        -- 47 << 3 | 3
        [379] = function ()
            self.enumValue2=Data.EchoEnum.checkReadValue(buf:ReadVar32());
        end ,
        -- 48 << 3 | 3
        [387] = function ()
            local enumValues2DataSize = buf:ReadVar32();
            self.enumValues2 = {};
            local receiveEnumValues2DataSize = 0;
            local readEnumValues2Index = 1;
            while(receiveEnumValues2DataSize < enumValues2DataSize ) do
                local tempEnumValues2 = buf:ReadVar32();
                receiveEnumValues2DataSize = receiveEnumValues2DataSize + buf:ComputeVar32Size(tempEnumValues2);
                self.enumValues2[readEnumValues2Index] = Data.EchoEnum.checkReadValue(tempEnumValues2);
                readEnumValues2Index = readEnumValues2Index + 1;
            end
        end
    }
    while(true) do
        local tag = buf:ReadTag(endIndex);
        if(tag == 0) then
            return;
        else
            local case = switch[tag];
            if(case) then
                case();
            else
                buf:Skip(tag);
            end
        end
    end
end

--Data.Echo计算序列化大小
function Data.Echo:getSerializedSize(buf)
    local size = self.serializedSize;
    if (size > -1) then
        return size;
    end
    size = 0;
    -- booleanValue
    -- tag size 已经完成了计算 8
    size = size + buf:ComputeBooleanSize(1, self.booleanValue);
    -- booleanValues
    if self.booleanValues then
        local booleanValues_len = #self.booleanValues
        local booleanValuesDataSize = 0;
        if booleanValues_len > 0 then
            for i = 1, booleanValues_len do
                booleanValuesDataSize = booleanValuesDataSize + buf:ComputeBooleanSizeNoTag(self.booleanValues[i] );
            end
        end
        self.booleanValuesSerializedSize = booleanValuesDataSize;
        if booleanValuesDataSize > 0 then
            -- tag size 已经完成了计算 19
            size = size + 1 + self.booleanValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.booleanValuesSerializedSize);
        end
    end
    -- intValue
    -- tag size 已经完成了计算 24
    size = size + buf:ComputeVar32Size(1, self.intValue);
    -- intValues
    if self.intValues then
        local intValues_len = #self.intValues
        local intValuesDataSize = 0;
        if intValues_len > 0 then
            for i = 1, intValues_len do
                intValuesDataSize = intValuesDataSize + buf:ComputeVar32SizeNoTag(self.intValues[i] );
            end
        end
        self.intValuesSerializedSize = intValuesDataSize;
        if intValuesDataSize > 0 then
            -- tag size 已经完成了计算 35
            size = size + 1 + self.intValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.intValuesSerializedSize);
        end
    end
    -- longValue
    -- tag size 已经完成了计算 40
    size = size + buf:ComputeVar64Size(1, self.longValue);
    -- longValues
    if self.longValues then
        local longValues_len = #self.longValues
        local longValuesDataSize = 0;
        if longValues_len > 0 then
            for i = 1, longValues_len do
                longValuesDataSize = longValuesDataSize + buf:ComputeVar64SizeNoTag(self.longValues[i] );
            end
        end
        self.longValuesSerializedSize = longValuesDataSize;
        if longValuesDataSize > 0 then
            -- tag size 已经完成了计算 51
            size = size + 1 + self.longValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.longValuesSerializedSize);
        end
    end
    -- sintValue
    -- tag size 已经完成了计算 56
    size = size + buf:ComputeSIntSize(1, self.sintValue);
    -- sintValues
    if self.sintValues then
        local sintValues_len = #self.sintValues
        local sintValuesDataSize = 0;
        if sintValues_len > 0 then
            for i = 1, sintValues_len do
                sintValuesDataSize = sintValuesDataSize + buf:ComputeSIntSizeNoTag(self.sintValues[i] );
            end
        end
        self.sintValuesSerializedSize = sintValuesDataSize;
        if sintValuesDataSize > 0 then
            -- tag size 已经完成了计算 67
            size = size + 1 + self.sintValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.sintValuesSerializedSize);
        end
    end
    -- slongValue
    -- tag size 已经完成了计算 72
    size = size + buf:ComputeSLongSize(1, self.slongValue);
    -- slongValues
    if self.slongValues then
        local slongValues_len = #self.slongValues
        local slongValuesDataSize = 0;
        if slongValues_len > 0 then
            for i = 1, slongValues_len do
                slongValuesDataSize = slongValuesDataSize + buf:ComputeSLongSizeNoTag(self.slongValues[i] );
            end
        end
        self.slongValuesSerializedSize = slongValuesDataSize;
        if slongValuesDataSize > 0 then
            -- tag size 已经完成了计算 83
            size = size + 1 + self.slongValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.slongValuesSerializedSize);
        end
    end
    -- floatValue
    -- tag size 已经完成了计算 89
    size = size + buf:ComputeFloatSize(1, self.floatValue);
    -- floatValues
    if self.floatValues then
        local floatValues_len = #self.floatValues
        local floatValuesDataSize = 0;
        if floatValues_len > 0 then
            for i = 1, floatValues_len do
                floatValuesDataSize = floatValuesDataSize + buf:ComputeFloatSizeNoTag(self.floatValues[i] );
            end
        end
        self.floatValuesSerializedSize = floatValuesDataSize;
        if floatValuesDataSize > 0 then
            -- tag size 已经完成了计算 99
            size = size + 1 + self.floatValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.floatValuesSerializedSize);
        end
    end
    -- doubleValue
    -- tag size 已经完成了计算 106
    size = size + buf:ComputeDoubleSize(1, self.doubleValue);
    -- doubleValues
    if self.doubleValues then
        local doubleValues_len = #self.doubleValues
        local doubleValuesDataSize = 0;
        if doubleValues_len > 0 then
            for i = 1, doubleValues_len do
                doubleValuesDataSize = doubleValuesDataSize + buf:ComputeDoubleSizeNoTag(self.doubleValues[i] );
            end
        end
        self.doubleValuesSerializedSize = doubleValuesDataSize;
        if doubleValuesDataSize > 0 then
            -- tag size 已经完成了计算 115
            size = size + 1 + self.doubleValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.doubleValuesSerializedSize);
        end
    end
    -- sfixed32Value
    -- tag size 已经完成了计算 121
    size = size + buf:ComputeSFixed32Size(1, self.sfixed32Value);
    -- sfixed32Values
    if self.sfixed32Values then
        local sfixed32Values_len = #self.sfixed32Values
        local sfixed32ValuesDataSize = 0;
        if sfixed32Values_len > 0 then
            for i = 1, sfixed32Values_len do
                sfixed32ValuesDataSize = sfixed32ValuesDataSize + buf:ComputeSFixed32SizeNoTag(self.sfixed32Values[i] );
            end
        end
        self.sfixed32ValuesSerializedSize = sfixed32ValuesDataSize;
        if sfixed32ValuesDataSize > 0 then
            -- tag size 已经完成了计算 131
            size = size + 2 + self.sfixed32ValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.sfixed32ValuesSerializedSize);
        end
    end
    -- sfixed64Value
    -- tag size 已经完成了计算 138
    size = size + buf:ComputeSFixed64Size(2, self.sfixed64Value);
    -- sfixed64Values
    if self.sfixed64Values then
        local sfixed64Values_len = #self.sfixed64Values
        local sfixed64ValuesDataSize = 0;
        if sfixed64Values_len > 0 then
            for i = 1, sfixed64Values_len do
                sfixed64ValuesDataSize = sfixed64ValuesDataSize + buf:ComputeSFixed64SizeNoTag(self.sfixed64Values[i] );
            end
        end
        self.sfixed64ValuesSerializedSize = sfixed64ValuesDataSize;
        if sfixed64ValuesDataSize > 0 then
            -- tag size 已经完成了计算 147
            size = size + 2 + self.sfixed64ValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.sfixed64ValuesSerializedSize);
        end
    end
    -- stringValue
    if self.stringValue then
        -- tag size 已经完成了计算 155
        size = size + buf:ComputeStringSize(2, self.stringValue);
    end
    -- stringValues
    if self.stringValues then
        local stringValues_len = #self.stringValues
        if stringValues_len > 0 then
            for i = 1, stringValues_len do
                -- tag size 已经完成了计算 163
                size = size + 2 + buf:ComputeStringSizeNoTag(self.stringValues[i] );
            end
        end
    end
    -- beanValue
    if self.beanValue then
        local beanValueBeanSize = self.beanValue:getSerializedSize(buf)
        -- tag size 已经完成了计算 171
        size = size + beanValueBeanSize + buf:ComputeVar32Size(2, beanValueBeanSize);
    end
    -- beanValues
    if self.beanValues then
        local beanValues_len = #self.beanValues
        if beanValues_len > 0 then
            for i = 1, beanValues_len do
                local beanValuesBeanSize = self.beanValues[i]:getSerializedSize(buf)
                -- tag size 已经完成了计算 179
                size = size + beanValuesBeanSize + buf:ComputeVar32Size(2,beanValuesBeanSize);
            end
        end
    end
    -- enumValue
    -- tag size 已经完成了计算 187
    size = size + buf:ComputeVar32Size(2, self.enumValue);
    -- enumValues
    if self.enumValues then
        local enumValuesDataSize = 0;
        local enumValues_len = #self.enumValues
        if enumValues_len > 0 then
            for i = 1, enumValues_len do
                enumValuesDataSize = enumValuesDataSize + buf:ComputeVar32SizeNoTag(self.enumValues[i] );
            end
        end
        self.enumValuesSerializedSize = enumValuesDataSize;
        if enumValuesDataSize > 0 then
            -- tag size 已经完成了计算 195
            size = size + 2 + self.enumValuesSerializedSize + buf:ComputeVar32SizeNoTag(self.enumValuesSerializedSize);
        end
    end
    -- tag size 已经完成了计算 200
    size = size + buf:ComputeBooleanSize(2, self.booleanValue2);
    if self.booleanValues2 then
        local booleanValues2_len = #self.booleanValues2
        local booleanValues2DataSize = 0;
        if booleanValues2_len > 0 then
            for i = 1, booleanValues2_len do
                booleanValues2DataSize = booleanValues2DataSize + buf:ComputeBooleanSizeNoTag(self.booleanValues2[i] );
            end
        end
        self.booleanValues2SerializedSize = booleanValues2DataSize;
        if booleanValues2DataSize > 0 then
            -- tag size 已经完成了计算 211
            size = size + 2 + self.booleanValues2SerializedSize + buf:ComputeVar32SizeNoTag(self.booleanValues2SerializedSize);
        end
    end
    -- tag size 已经完成了计算 216
    size = size + buf:ComputeVar32Size(2, self.intValue2);
    if self.intValues2 then
        local intValues2_len = #self.intValues2
        local intValues2DataSize = 0;
        if intValues2_len > 0 then
            for i = 1, intValues2_len do
                intValues2DataSize = intValues2DataSize + buf:ComputeVar32SizeNoTag(self.intValues2[i] );
            end
        end
        self.intValues2SerializedSize = intValues2DataSize;
        if intValues2DataSize > 0 then
            -- tag size 已经完成了计算 227
            size = size + 2 + self.intValues2SerializedSize + buf:ComputeVar32SizeNoTag(self.intValues2SerializedSize);
        end
    end
    -- tag size 已经完成了计算 232
    size = size + buf:ComputeVar64Size(2, self.longValue2);
    if self.longValues2 then
        local longValues2_len = #self.longValues2
        local longValues2DataSize = 0;
        if longValues2_len > 0 then
            for i = 1, longValues2_len do
                longValues2DataSize = longValues2DataSize + buf:ComputeVar64SizeNoTag(self.longValues2[i] );
            end
        end
        self.longValues2SerializedSize = longValues2DataSize;
        if longValues2DataSize > 0 then
            -- tag size 已经完成了计算 243
            size = size + 2 + self.longValues2SerializedSize + buf:ComputeVar32SizeNoTag(self.longValues2SerializedSize);
        end
    end
    -- tag size 已经完成了计算 248
    size = size + buf:ComputeSIntSize(2, self.sintValue2);
    if self.sintValues2 then
        local sintValues2_len = #self.sintValues2
        local sintValues2DataSize = 0;
        if sintValues2_len > 0 then
            for i = 1, sintValues2_len do
                sintValues2DataSize = sintValues2DataSize + buf:ComputeSIntSizeNoTag(self.sintValues2[i] );
            end
        end
        self.sintValues2SerializedSize = sintValues2DataSize;
        if sintValues2DataSize > 0 then
            -- tag size 已经完成了计算 259
            size = size + 2 + self.sintValues2SerializedSize + buf:ComputeVar32SizeNoTag(self.sintValues2SerializedSize);
        end
    end
    -- tag size 已经完成了计算 264
    size = size + buf:ComputeSLongSize(2, self.slongValue2);
    if self.slongValues2 then
        local slongValues2_len = #self.slongValues2
        local slongValues2DataSize = 0;
        if slongValues2_len > 0 then
            for i = 1, slongValues2_len do
                slongValues2DataSize = slongValues2DataSize + buf:ComputeSLongSizeNoTag(self.slongValues2[i] );
            end
        end
        self.slongValues2SerializedSize = slongValues2DataSize;
        if slongValues2DataSize > 0 then
            -- tag size 已经完成了计算 275
            size = size + 2 + self.slongValues2SerializedSize + buf:ComputeVar32SizeNoTag(self.slongValues2SerializedSize);
        end
    end
    -- tag size 已经完成了计算 281
    size = size + buf:ComputeFloatSize(2, self.floatValue2);
    if self.floatValues2 then
        local floatValues2_len = #self.floatValues2
        local floatValues2DataSize = 0;
        if floatValues2_len > 0 then
            for i = 1, floatValues2_len do
                floatValues2DataSize = floatValues2DataSize + buf:ComputeFloatSizeNoTag(self.floatValues2[i] );
            end
        end
        self.floatValues2SerializedSize = floatValues2DataSize;
        if floatValues2DataSize > 0 then
            -- tag size 已经完成了计算 291
            size = size + 2 + self.floatValues2SerializedSize + buf:ComputeVar32SizeNoTag(self.floatValues2SerializedSize);
        end
    end
    -- tag size 已经完成了计算 298
    size = size + buf:ComputeDoubleSize(2, self.doubleValue2);
    if self.doubleValues2 then
        local doubleValues2_len = #self.doubleValues2
        local doubleValues2DataSize = 0;
        if doubleValues2_len > 0 then
            for i = 1, doubleValues2_len do
                doubleValues2DataSize = doubleValues2DataSize + buf:ComputeDoubleSizeNoTag(self.doubleValues2[i] );
            end
        end
        self.doubleValues2SerializedSize = doubleValues2DataSize;
        if doubleValues2DataSize > 0 then
            -- tag size 已经完成了计算 307
            size = size + 2 + self.doubleValues2SerializedSize + buf:ComputeVar32SizeNoTag(self.doubleValues2SerializedSize);
        end
    end
    -- tag size 已经完成了计算 313
    size = size + buf:ComputeSFixed32Size(2, self.sfixed32Value2);
    if self.sfixed32Values2 then
        local sfixed32Values2_len = #self.sfixed32Values2
        local sfixed32Values2DataSize = 0;
        if sfixed32Values2_len > 0 then
            for i = 1, sfixed32Values2_len do
                sfixed32Values2DataSize = sfixed32Values2DataSize + buf:ComputeSFixed32SizeNoTag(self.sfixed32Values2[i] );
            end
        end
        self.sfixed32Values2SerializedSize = sfixed32Values2DataSize;
        if sfixed32Values2DataSize > 0 then
            -- tag size 已经完成了计算 323
            size = size + 2 + self.sfixed32Values2SerializedSize + buf:ComputeVar32SizeNoTag(self.sfixed32Values2SerializedSize);
        end
    end
    -- tag size 已经完成了计算 330
    size = size + buf:ComputeSFixed64Size(2, self.sfixed64Value2);
    if self.sfixed64Values2 then
        local sfixed64Values2_len = #self.sfixed64Values2
        local sfixed64Values2DataSize = 0;
        if sfixed64Values2_len > 0 then
            for i = 1, sfixed64Values2_len do
                sfixed64Values2DataSize = sfixed64Values2DataSize + buf:ComputeSFixed64SizeNoTag(self.sfixed64Values2[i] );
            end
        end
        self.sfixed64Values2SerializedSize = sfixed64Values2DataSize;
        if sfixed64Values2DataSize > 0 then
            -- tag size 已经完成了计算 339
            size = size + 2 + self.sfixed64Values2SerializedSize + buf:ComputeVar32SizeNoTag(self.sfixed64Values2SerializedSize);
        end
    end
    if self.stringValue2 then
        -- tag size 已经完成了计算 347
        size = size + buf:ComputeStringSize(2, self.stringValue2);
    end
    if self.stringValues2 then
        local stringValues2_len = #self.stringValues2
        if stringValues2_len > 0 then
            for i = 1, stringValues2_len do
                -- tag size 已经完成了计算 355
                size = size + 2 + buf:ComputeStringSizeNoTag(self.stringValues2[i] );
            end
        end
    end
    if self.beanValue2 then
        local beanValue2BeanSize = self.beanValue2:getSerializedSize(buf)
        -- tag size 已经完成了计算 363
        size = size + beanValue2BeanSize + buf:ComputeVar32Size(2, beanValue2BeanSize);
    end
    if self.beanValues2 then
        local beanValues2_len = #self.beanValues2
        if beanValues2_len > 0 then
            for i = 1, beanValues2_len do
                local beanValues2BeanSize = self.beanValues2[i]:getSerializedSize(buf)
                -- tag size 已经完成了计算 371
                size = size + beanValues2BeanSize + buf:ComputeVar32Size(2,beanValues2BeanSize);
            end
        end
    end
    -- tag size 已经完成了计算 379
    size = size + buf:ComputeVar32Size(2, self.enumValue2);
    if self.enumValues2 then
        local enumValues2DataSize = 0;
        local enumValues2_len = #self.enumValues2
        if enumValues2_len > 0 then
            for i = 1, enumValues2_len do
                enumValues2DataSize = enumValues2DataSize + buf:ComputeVar32SizeNoTag(self.enumValues2[i] );
            end
        end
        self.enumValues2SerializedSize = enumValues2DataSize;
        if enumValues2DataSize > 0 then
            -- tag size 已经完成了计算 387
            size = size + 2 + self.enumValues2SerializedSize + buf:ComputeVar32SizeNoTag(self.enumValues2SerializedSize);
        end
    end
    self.serializedSize = size ;
    return size ;
end

--Data.Echo格式化字符串
function Data.Echo:toString(_indent)
    _indent = _indent or ""
    local _str = ""
    _str = _str .. "Echo" .. "{"
    --booleanValue
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("booleanValue", self._filedPad) .. " = " .. tostring(self.booleanValue)
    --booleanValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("booleanValues", self._filedPad) .. " = "
    if self.booleanValues then
        local booleanValues_len = #self.booleanValues
        if booleanValues_len > 0 then
            _str = _str .. "["
            for i = 1,booleanValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. tostring(self.booleanValues[i])
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --intValue
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("intValue",self._filedPad) .. " = " .. self.intValue
    --intValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("intValues", self._filedPad) .. " = "
    if self.intValues then
        local intValues_len = #self.intValues
        if intValues_len > 0 then
            _str = _str .. "["
            for i = 1,intValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.intValues[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --longValue
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("longValue",self._filedPad) .. " = " .. self.longValue
    --longValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("longValues", self._filedPad) .. " = "
    if self.longValues then
        local longValues_len = #self.longValues
        if longValues_len > 0 then
            _str = _str .. "["
            for i = 1,longValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.longValues[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --sintValue
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sintValue",self._filedPad) .. " = " .. self.sintValue
    --sintValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sintValues", self._filedPad) .. " = "
    if self.sintValues then
        local sintValues_len = #self.sintValues
        if sintValues_len > 0 then
            _str = _str .. "["
            for i = 1,sintValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.sintValues[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --slongValue
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("slongValue",self._filedPad) .. " = " .. self.slongValue
    --slongValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("slongValues", self._filedPad) .. " = "
    if self.slongValues then
        local slongValues_len = #self.slongValues
        if slongValues_len > 0 then
            _str = _str .. "["
            for i = 1,slongValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.slongValues[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --floatValue
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("floatValue",self._filedPad) .. " = " .. self.floatValue
    --floatValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("floatValues", self._filedPad) .. " = "
    if self.floatValues then
        local floatValues_len = #self.floatValues
        if floatValues_len > 0 then
            _str = _str .. "["
            for i = 1,floatValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.floatValues[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --doubleValue
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("doubleValue",self._filedPad) .. " = " .. self.doubleValue
    --doubleValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("doubleValues", self._filedPad) .. " = "
    if self.doubleValues then
        local doubleValues_len = #self.doubleValues
        if doubleValues_len > 0 then
            _str = _str .. "["
            for i = 1,doubleValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.doubleValues[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --sfixed32Value
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sfixed32Value",self._filedPad) .. " = " .. self.sfixed32Value
    --sfixed32Values
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sfixed32Values", self._filedPad) .. " = "
    if self.sfixed32Values then
        local sfixed32Values_len = #self.sfixed32Values
        if sfixed32Values_len > 0 then
            _str = _str .. "["
            for i = 1,sfixed32Values_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.sfixed32Values[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --sfixed64Value
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sfixed64Value",self._filedPad) .. " = " .. self.sfixed64Value
    --sfixed64Values
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sfixed64Values", self._filedPad) .. " = "
    if self.sfixed64Values then
        local sfixed64Values_len = #self.sfixed64Values
        if sfixed64Values_len > 0 then
            _str = _str .. "["
            for i = 1,sfixed64Values_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.sfixed64Values[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --stringValue
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("stringValue",self._filedPad) .. " = " .. self.stringValue
    --stringValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("stringValues", self._filedPad) .. " = "
    if self.stringValues then
        local stringValues_len = #self.stringValues
        if stringValues_len > 0 then
            _str = _str .. "["
            for i = 1,stringValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.stringValues[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --beanValue
    _str = _str .. "\n"
    if self.beanValue then
        _str = _str .. _indent .. rightPad("beanValue", self._filedPad) .. " = " .. self.beanValue:toString(_indent .. self._next_indent)
    else
        _str = _str .. _indent .. rightPad("beanValue", self._filedPad) .. " = " .. "nil"
    end
    --beanValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("beanValues", self._filedPad) .. " = "
    if self.beanValues then
        local beanValues_len = #self.beanValues
        if beanValues_len > 0 then
            _str = _str .. "["
            for i = 1,beanValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.beanValues[i]:toString(_indent .. self._next_indent)
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    --enumValue
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("enumValue",self._filedPad) .. " = " .. Data.EchoEnum.valueToStr(self.enumValue)
    --enumValues
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("enumValues", self._filedPad) .. " = "
    if self.enumValues then
        local enumValues_len = #self.enumValues
        if enumValues_len > 0 then
            _str = _str .. "["
            for i = 1,enumValues_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .._indent .. Data.EchoEnum.valueToStr(self.enumValues[i])
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("booleanValue2", self._filedPad) .. " = " .. tostring(self.booleanValue2)
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("booleanValues2", self._filedPad) .. " = "
    if self.booleanValues2 then
        local booleanValues2_len = #self.booleanValues2
        if booleanValues2_len > 0 then
            _str = _str .. "["
            for i = 1,booleanValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. tostring(self.booleanValues2[i])
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("intValue2",self._filedPad) .. " = " .. self.intValue2
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("intValues2", self._filedPad) .. " = "
    if self.intValues2 then
        local intValues2_len = #self.intValues2
        if intValues2_len > 0 then
            _str = _str .. "["
            for i = 1,intValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.intValues2[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("longValue2",self._filedPad) .. " = " .. self.longValue2
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("longValues2", self._filedPad) .. " = "
    if self.longValues2 then
        local longValues2_len = #self.longValues2
        if longValues2_len > 0 then
            _str = _str .. "["
            for i = 1,longValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.longValues2[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sintValue2",self._filedPad) .. " = " .. self.sintValue2
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sintValues2", self._filedPad) .. " = "
    if self.sintValues2 then
        local sintValues2_len = #self.sintValues2
        if sintValues2_len > 0 then
            _str = _str .. "["
            for i = 1,sintValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.sintValues2[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("slongValue2",self._filedPad) .. " = " .. self.slongValue2
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("slongValues2", self._filedPad) .. " = "
    if self.slongValues2 then
        local slongValues2_len = #self.slongValues2
        if slongValues2_len > 0 then
            _str = _str .. "["
            for i = 1,slongValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.slongValues2[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("floatValue2",self._filedPad) .. " = " .. self.floatValue2
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("floatValues2", self._filedPad) .. " = "
    if self.floatValues2 then
        local floatValues2_len = #self.floatValues2
        if floatValues2_len > 0 then
            _str = _str .. "["
            for i = 1,floatValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.floatValues2[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("doubleValue2",self._filedPad) .. " = " .. self.doubleValue2
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("doubleValues2", self._filedPad) .. " = "
    if self.doubleValues2 then
        local doubleValues2_len = #self.doubleValues2
        if doubleValues2_len > 0 then
            _str = _str .. "["
            for i = 1,doubleValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.doubleValues2[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sfixed32Value2",self._filedPad) .. " = " .. self.sfixed32Value2
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sfixed32Values2", self._filedPad) .. " = "
    if self.sfixed32Values2 then
        local sfixed32Values2_len = #self.sfixed32Values2
        if sfixed32Values2_len > 0 then
            _str = _str .. "["
            for i = 1,sfixed32Values2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.sfixed32Values2[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sfixed64Value2",self._filedPad) .. " = " .. self.sfixed64Value2
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("sfixed64Values2", self._filedPad) .. " = "
    if self.sfixed64Values2 then
        local sfixed64Values2_len = #self.sfixed64Values2
        if sfixed64Values2_len > 0 then
            _str = _str .. "["
            for i = 1,sfixed64Values2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.sfixed64Values2[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("stringValue2",self._filedPad) .. " = " .. self.stringValue2
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("stringValues2", self._filedPad) .. " = "
    if self.stringValues2 then
        local stringValues2_len = #self.stringValues2
        if stringValues2_len > 0 then
            _str = _str .. "["
            for i = 1,stringValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.stringValues2[i]
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    if self.beanValue2 then
        _str = _str .. _indent .. rightPad("beanValue2", self._filedPad) .. " = " .. self.beanValue2:toString(_indent .. self._next_indent)
    else
        _str = _str .. _indent .. rightPad("beanValue2", self._filedPad) .. " = " .. "nil"
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("beanValues2", self._filedPad) .. " = "
    if self.beanValues2 then
        local beanValues2_len = #self.beanValues2
        if beanValues2_len > 0 then
            _str = _str .. "["
            for i = 1,beanValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .. _indent .. self.beanValues2[i]:toString(_indent .. self._next_indent)
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("enumValue2",self._filedPad) .. " = " .. Data.EchoEnum.valueToStr(self.enumValue2)
    _str = _str .. "\n"
    _str = _str .. _indent .. rightPad("enumValues2", self._filedPad) .. " = "
    if self.enumValues2 then
        local enumValues2_len = #self.enumValues2
        if enumValues2_len > 0 then
            _str = _str .. "["
            for i = 1,enumValues2_len do
                _str = _str .. "\n"
                _str = _str .. self._next_indent
                _str = _str .._indent .. Data.EchoEnum.valueToStr(self.enumValues2[i])
            end
            _str = _str .. "\n"
            _str = _str .. self._next_indent
            _str = _str .. _indent .. "]"
        else
            _str = _str .. "nil "
        end
    else
        _str = _str .. "nil "
    end
    _str =_str .. "\n"
    _str = _str .. _indent .. "}"
    return _str
end


Data.CSEchoMessage = {
    --[Comment]
    --message_id
    messageId = 1000103;
    --[Comment]
    --类型:Data.Echo
    echo = nil ;
    serializedSize = -1;
    --缩进4 + 3 = 7 个空格
    _next_indent = "       ";
    --格式化时统一字段长度
    _filedPad = 4 ;
}

--Data.CSEchoMessage构造方法
function Data.CSEchoMessage:new()
    local cSEchoMessage = setmetatable({}, {__index=self}) ;
    --[Comment]
    --类型:DataEcho
    cSEchoMessage.echo = nil ;
    serializedSize = -1;
    return cSEchoMessage;
end

--Data.CSEchoMessage写入字节缓存
function Data.CSEchoMessage:write(buf)
    self:getSerializedSize(buf);
    if self.echo then
        buf:WriteVar32(11);
        buf:WriteVar32(self.echo:getSerializedSize(buf));
        self.echo:write(buf);
    end
end

--Data.CSEchoMessage读取字节缓存
function Data.CSEchoMessage:read(buf,endIndex)
    local switch = {
        -- 1 << 3 | 3
        [11] = function ()
            self.echo = Data.Echo:new()
            self.echo:read(buf,buf:ReadVar32()+buf:ReaderIndex())
        end
    }
    while(true) do
        local tag = buf:ReadTag(endIndex);
        if(tag == 0) then
            return;
        else
            local case = switch[tag];
            if(case) then
                case();
            else
                buf:Skip(tag);
            end
        end
    end
end

--Data.CSEchoMessage计算序列化大小
function Data.CSEchoMessage:getSerializedSize(buf)
    local size = self.serializedSize;
    if (size > -1) then
        return size;
    end
    size = 0;
    if self.echo then
        local echoBeanSize = self.echo:getSerializedSize(buf)
        -- tag size 已经完成了计算 11
        size = size + echoBeanSize + buf:ComputeVar32Size(1, echoBeanSize);
    end
    self.serializedSize = size ;
    return size ;
end

--Data.CSEchoMessage格式化字符串
function Data.CSEchoMessage:toString(_indent)
    _indent = _indent or ""
    local _str = ""
    _str = _str .. "CSEchoMessage[1000103]" .. "{"
    _str = _str .. "\n"
    if self.echo then
        _str = _str .. _indent .. rightPad("echo", self._filedPad) .. " = " .. self.echo:toString(_indent .. self._next_indent)
    else
        _str = _str .. _indent .. rightPad("echo", self._filedPad) .. " = " .. "nil"
    end
    _str =_str .. "\n"
    _str = _str .. _indent .. "}"
    return _str
end

Data.SCEchoMessage = {
    --[Comment]
    --message_id
    messageId = 1000104;
    --[Comment]
    --类型:Data.Echo
    echo = nil ;
    serializedSize = -1;
    --缩进4 + 3 = 7 个空格
    _next_indent = "       ";
    --格式化时统一字段长度
    _filedPad = 4 ;
}

--Data.SCEchoMessage构造方法
function Data.SCEchoMessage:new()
    local sCEchoMessage = setmetatable({}, {__index=self}) ;
    --[Comment]
    --类型:DataEcho
    sCEchoMessage.echo = nil ;
    serializedSize = -1;
    return sCEchoMessage;
end

--Data.SCEchoMessage写入字节缓存
function Data.SCEchoMessage:write(buf)
    self:getSerializedSize(buf);
    if self.echo then
        buf:WriteVar32(11);
        buf:WriteVar32(self.echo:getSerializedSize(buf));
        self.echo:write(buf);
    end
end

--Data.SCEchoMessage读取字节缓存
function Data.SCEchoMessage:read(buf,endIndex)
    local switch = {
        -- 1 << 3 | 3
        [11] = function ()
            self.echo = Data.Echo:new()
            self.echo:read(buf,buf:ReadVar32()+buf:ReaderIndex())
        end
    }
    while(true) do
        local tag = buf:ReadTag(endIndex);
        if(tag == 0) then
            return;
        else
            local case = switch[tag];
            if(case) then
                case();
            else
                buf:Skip(tag);
            end
        end
    end
end

--Data.SCEchoMessage计算序列化大小
function Data.SCEchoMessage:getSerializedSize(buf)
    local size = self.serializedSize;
    if (size > -1) then
        return size;
    end
    size = 0;
    if self.echo then
        local echoBeanSize = self.echo:getSerializedSize(buf)
        -- tag size 已经完成了计算 11
        size = size + echoBeanSize + buf:ComputeVar32Size(1, echoBeanSize);
    end
    self.serializedSize = size ;
    return size ;
end

--Data.SCEchoMessage格式化字符串
function Data.SCEchoMessage:toString(_indent)
    _indent = _indent or ""
    local _str = ""
    _str = _str .. "SCEchoMessage[1000104]" .. "{"
    _str = _str .. "\n"
    if self.echo then
        _str = _str .. _indent .. rightPad("echo", self._filedPad) .. " = " .. self.echo:toString(_indent .. self._next_indent)
    else
        _str = _str .. _indent .. rightPad("echo", self._filedPad) .. " = " .. "nil"
    end
    _str =_str .. "\n"
    _str = _str .. _indent .. "}"
    return _str
end


ConsumerManager.regMessageDecoder(Data.SCEchoMessage.messageId,
        {
            getEmptyMessage = function()
                return Data.SCEchoMessage:new();
            end
        },"Data.SCEchoMessage");
