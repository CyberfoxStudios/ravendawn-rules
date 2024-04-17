--[[Problems with the original code:
   1. The hardcoded values: 1000, -1, 1.
   2. Error handling
   3. 1000 delay argument
   4. 'storing' unneeded -1 value
]]

--This new variable allows easy configuration of the '1000' parameter
--and improves code readability.
local STORAGE_LOCATION = 1000

--The original function sets the value at index 1000 for player to -1,
--"releasing" the data.
local function releaseStorage(player)
   player:setStorageValue(STORAGE_LOCATION, nil) --instead of -1, let's release this value. that way we both free memory and can use '-1' as a possible value
end

--Presumably this function is called when logging out 
--The original function has handling to release the storage if the value at 1000 is equal to one
function onLogout(player) --I'm not sure why this function is global, but I would make sure it needs to be global or we can switch to local to save access time
   --Error Handling
   if player == nil then
    log_error("Error: onLogout player not initialized")
    return false
   end

   if player:getStorageValue(STORAGE_LOCATION) ~= nil then --by switching this to the inverse case, we permit all other values besides -1 as the storage value. 
                                                           --by switching it to nil, we allow all values. if we were going for a very specific value locking scenario where 
                                                           --we only want storage to equal -1 or 1, i would consider using more descriptive names
      addEvent(releaseStorage, 0, player) --usually 1000 in this context would indicate an async time delay argument of 1000 ms. 
                                          --I see no need to add delay to this code execution, so I switched it to 0. 
                                          --If instead 1000 is another index reference similar to get and set storage, I'd use STORAGE_LOCATION.
   end

   return true
end

