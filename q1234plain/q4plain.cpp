#include <memory> // for unique_ptr

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    // This function creates an item by itemID and adds to the recipient player inbox

    // Find player
    std::unique_ptr<Player> player(g_game.getPlayerByName(recipient));
    if (!player) { // If player doesn't exist in g_game, try to load from IOLoginData
        player.reset(new Player(nullptr));
        if (!IOLoginData::loadPlayerByName(player.get(), recipient)) {
            logError("Error: addItemToPlayer - recipient not found");
            return;
        }
    }

    // Create Item
    std::unique_ptr<Item> item(Item::CreateItem(itemId));
    if (!item) {
        logError("Error: addItemToPlayer - item not found");
        return;
    }

    // Add the item to the player inbox
    g_game.internalAddItem(player->getInbox(), item.get(), INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}