local mod = RegisterMod("Love Burns", 1)
local loveBurns = Isaac.GetItemIdByName("Love Burns")
local tearsDelay = -1

function mod:EvaluateCache(player, flags)
   if flags & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
      local itemCount = player:GetCollectibleNum(loveBurns)
      player.MaxFireDelay = player.MaxFireDelay + tearsDelay * itemCount
   end
end

function mod:EntityTakeDamage(entity, amount, flags, source, frames)
   if flags & DamageFlag.DAMAGE_FIRE == DamageFlag.DAMAGE_FIRE then
      if entity.Type & EntityType.ENTITY_PLAYER == EntityType.ENTITY_PLAYER then
         if Isaac.GetPlayer():HasCollectible(loveBurns) then
            return false
         end
      end
   end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.EntityTakeDamage)