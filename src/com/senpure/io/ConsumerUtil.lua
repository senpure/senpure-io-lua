logger = {}
logger.trace = function(value)
    print(value)
end
logger.debug = function(value)
    print(value)
end

logger.info = function(value)
    print(value)
end

function rightPad(_str, _pad)
    local _str_len = #_str
    for i = 1, _pad do
        if i > _str_len then
            _str = _str .. " "
        end
    end
    return _str
end


