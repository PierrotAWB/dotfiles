local yop = require("yop")

local function createOpMap(key, wrapperFunction)
    yop.op_map({ "n", "v" }, key, function(lines, info)
        local wrappedLines = {}
        for _, line in ipairs(lines) do
            table.insert(wrappedLines, wrapperFunction(line))
        end
        return wrappedLines
    end)
end

createOpMap("<leader>j", function(line) return 'JSON.stringify(' .. line .. ', null, 2)' end)
createOpMap("<leader>l", function(line) return 'console.log(' .. line .. ')' end)
createOpMap("<leader>a", function(line) return 'Alert.alert(' .. line .. ')' end)
