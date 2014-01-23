# **Jessassin's zombie server project -thing**

This is a set of commandhelper packages for use in my upcoming server.

***

### License:
* You may download an use the code as-is, so long as the code is not used in a for-profit manner.
* You may modify the code and use the modification in any way you wish, even for profit.
* Any modification of the code must be publicly distributed, under the same license.
* You must give credit to me as the original author.
* You must provide a link back to this original source.
* You must make note of any changes you have made to your version of the code.
* Your link-back must not suggest that I endorse your modifications of the code.

***

### Completed features:
* Chat features (prefix, suffix)
* Command Signs (ex: [command] /heal playername) runs /heal playername as OP
* Custom Spawning (Only tested for zombies) Allows for enabling/disabling mobs, as well as equipment customization
* Login handler (provides on-login events, and returns changable MOTD without server restart)
* Loot boxes (players gain loot based on respawnable loot boxes)

***

### Upcoming features:
* In-game news / changelog
* Econonomy system (banks / wallets)
* Economy system (Purchase items from "admin" shops)
* Economy system (Purchase items from "player" shops)
* Economy system (Purchase shops / plots)
* Mini-games (Play mini-games in designated buildings / areas for in-game rewards)
* Rare weapons / armor spawning or rewards from mini-games
* Experience system to allow for more health, faster mining, more damage, etc.
* Leaderboards for money, experience, kills, etc.
* Item breakdown: Melt damaged armor/weapons for their original materials
* Item breakdown: Remove enchantment from an item to receive XP bottles (or some other item, idk)
* Wallet system: Wallets can only carry a certain amount of money by default
* Wallet system: Upgrade your wallet by breaking down leather armor dropped by zombies
* Wallet system: Store excess money in your bank account
* Bank system: Earn interest on banked money while logged in
* Bank system: Access to ender chest if some condition is met
* Party system: Create / join parties for easier collaboration
* Party system: When joining minigames, all members of the party are queued together
* Clan system: Rank-based clan system
* Clan system: Clans can have their own bank account, which accumulates interest based on number of clan members online(?)
* Clan system: Clan can purchase property, and all members of clan can build on clan-owned property
* Clan system: Members of clans are automatically partied together(?)
* Private chat channels for mods, admins, party members, clan members, etc.
* Offline messaging system
* Other things that I have forgotten, or have not thought of yet.

***

### Dependancies:
* [WorldEdit](http://dev.bukkit.org/server-mods/worldedit/)(5.3+)
* [WorldGuard](http://dev.bukkit.org/server-mods/worldguard/)(5.0+)
* MySQL database
* CommandHelper Build 2511+
* Permissions plugin of some sort