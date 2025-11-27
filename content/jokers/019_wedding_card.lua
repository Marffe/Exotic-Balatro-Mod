SMODS.Joker {
    key = "wedding_card", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = { extra = { xmult = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local has_king = false
            local has_queen = false
            
            -- Check if hand contains both K and Q
            for i = 1, #context.scoring_hand do
                local scoring_card = context.scoring_hand[i]
                local rank = scoring_card:get_id()
                
                if rank == 13 then -- King
                    has_king = true
                end
                if rank == 12 then -- Queen
                    has_queen = true
                end
                
                if has_king and has_queen then
                    break
                end
            end
            
            if has_king and has_queen then
                return { xmult = card.ability.extra.xmult, card = card }
            end
        end
    end,
}