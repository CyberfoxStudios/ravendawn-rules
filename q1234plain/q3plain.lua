function removeMemberFromParty(playerId, membername)
   -- This method iterates through the playerId's party
   -- to look for the membername and remove it.

   -- access player party while ensuring our parameters are valid
   local player = Player(playerId)
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
   for partyMemberID,partyMember in pairs(party:getMembers()) do
      if partyMember == Player(membername) then
         party:removeMember(Player(membername))
         return
      end
   end

   logError("Error: removeMemberFromParty - Member not in party")
end