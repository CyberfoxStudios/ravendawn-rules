/*  The main memory issue here is that in C++
    when memory is dynamically allocated with new
    a la `player = new Player(nullptr)`
    it must be explicitly deallocated with delete.

    If we use the modern 'smart pointer' concept,
    the memory will automatically be handled without
    needing to write explicit delete statements for each path.

    If we are using an older build of C++,
    then we can use delete statements instead.
*/
#include <memory> //unique_ptr definition

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    // This function creates an item by itemID and adds to the recipient player inbox

    // Find player
    std::unique_ptr<Player> player(g_game.getPlayerByName(recipient));
    if (!player) { // If player doesn't exist in g_game, try to load from IOLoginData
        player.reset(new Player(nullptr)); // Dynamically allocate player memory here, without smart pointer we would need to clean it up on every subsequent path
        if (!IOLoginData::loadPlayerByName(player.get(), recipient)) { //Use .get to pass the raw pointer while keeping player in this scope
            logError("Error: addItemToPlayer - recipient not found"); //We should add some messaging if we try but fail to add an item
            return;
        }
    }

    // Create Item
    std::unique_ptr<Item> item(Item::CreateItem(itemId)); // Using a smart pointer here allows us to not worry if createitem also dynamically allocates with new
    if (!item) {
        logError("Error: addItemToPlayer - item not found");
        return;
    }

    // Add the item to the player inbox
    g_game.internalAddItem(player->getInbox(), item.get(), INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    // no cleanup necessary thanks to smart pointers!
}