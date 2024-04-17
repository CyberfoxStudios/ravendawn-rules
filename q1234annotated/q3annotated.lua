function removeMemberFromParty(playerId, membername) -- generally prefer snake_case for lua but camelCase is consistent with other questions. ideally seek to match style to team
   -- This method iterates through the playerId's party
   -- to look for the membername and remove it.

   -- access player party while ensuring our parameters are valid
   local player = Player(playerId) -- no clear need to make player global yet
   if not player then
      logError("Error: removeMemberFromParty - Player not found")
      return
   end

   local party = player:getParty()
   if not party then
       logError("Error: removeMemberFromParty - No party found")
       return
   end

   -- iterate through party to find membername
   for partyMemberID,partyMember in pairs(party:getMembers()) do -- I like to make k,v more descriptive, again will match style
      if partyMember == Player(membername) then
         party:removeMember(Player(membername)) --worth noting that if we add null handling to removeMember,
                                                --we could just call it outright instead of looping through the party
         return -- a player should not be able to be in the party twice,
                -- so we can execute faster by stopping if we find the player to remove
      end
   end

   logError("Error: removeMemberFromParty - Member not in party")
end