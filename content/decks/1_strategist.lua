-- TO DO:
-- Bonus Selection isnt reflected properly in Tags
-- Still think of a downside
SMODS.Back { -- Boolean for the win
    key = "strategist", atlas = "joker_atlas", pos = { x = 4, y = 2 },
    config = { extra = { shop_hand_size = 6, active = false, } },
    loc_vars = function(self, info_queue, back)
        return { vars = {  self.config.extra.shop_hand_size } }
    end,

    apply = function(self) G.GAME.strategist_bonus_pack = true end, -- G.GAME.strategist_bonus_pack is in the lovely patch

    calculate = function(self, back, context)
        if context.entering_shop and self.config.extra.active == false then
            self.config.extra.active = true
            G.hand:change_size(self.config.extra.shop_hand_size)
        end

        if context.setting_blind and self.config.extra.active == true and not context.blueprint then
            self.config.extra.active = false
            G.hand:change_size(-self.config.extra.shop_hand_size)
        end

        if context.end_of_round and self.config.extra.active == false and context.game_over == false and not context.blueprint then
            self.config.extra.active = true
            G.hand:change_size(self.config.extra.shop_hand_size)
        end
    end
}