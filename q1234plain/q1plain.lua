local STORAGE_LOCATION = 1000 --Index for player storage


local function releaseStorage(player)
  --This method releases the data at STORAGE_LOCATION for a given player
   player:setStorageValue(STORAGE_LOCATION, nil)
end

function onLogout(player)
   --This method schedules events that should happen in response to logout

   --Error Handling
   if player == nil then
      log_error("Error: onLogout player not initialized")
      return false
   end

   --Clear player storage if in use
   if player:getStorageValue(STORAGE_LOCATION) ~= nil then
      addEvent(releaseStorage, 0, player) -- 0 = no delay
   end

   return true
end

