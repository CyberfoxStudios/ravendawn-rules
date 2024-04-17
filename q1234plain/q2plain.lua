function printSmallGuildNames(memberCount)
   -- this method prints names of all guilds that have less than memberCount max_members
   -- memberCount should be a positive integer
   if type(memberCount) ~= "number" or memberCount <= 0 then
      print("Error: printSmallGuildNames - Invalid memberCount.")
      return
   end

   -- run and store query for guild names
   local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
   local result = db.storeQuery(string.format(selectGuildQuery, memberCount))

   if not result then
    print("Error: printSmallGuildNames - Query failed to execute.")
    return
   end

   if result:rowcount() == 0 then
      print("No guilds found with less members than memberCount.")
   end

   -- create and print list of guild names
   local guildNames = ""
   while result:next() do
      guildNames = guildNames .. result:get("name") .. " "
   end
   print(guildNames)

   result:free()

end