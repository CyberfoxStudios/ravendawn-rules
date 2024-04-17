-- the main issue with the original code
-- is that it attempts to print the entire query result
-- with a single print statement, instead of iterating through the result

function printSmallGuildNames(memberCount)
   -- this method is supposed to print names of all guilds that have less than memberCount max members

   -- input-proof memberCount: should be a positive integer
   if type(memberCount) ~= "number" or memberCount <= 0 then
      print("Error: printSmallGuildNames - Invalid memberCount.")
      return
   end

   local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
   local result = db.storeQuery(string.format(selectGuildQuery, memberCount)) --it looks like result and resultId were meant to be the same

   -- error handling
   if not result then
      print("Error: printSmallGuildNames - Query failed to execute.")
      return
   end

   if result:rowcount() == 0 then -- we should display *something* if we succesfully find all zero guilds
      print("No guilds found with less members than memberCount.")
   end

   -- create and print list of guild names
   local guildNames = ""
   while result:next() do
      guildNames = guildNames .. result:get("name") .. " " -- the extra space provides some readability between names
   end
   print(guildNames) -- by modifying the guildnames var and printing only once, we can save some execution time

   result:free() -- db release, memory cleanup

end