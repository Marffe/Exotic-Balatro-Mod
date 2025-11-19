SMODS.Joker {
    key = "bust", atlas = "joker_atlas", pos = { x = 2, y = 0 }, -- Rare

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 3, cost = 8, discovered = true, unlocked = true,

    config = { extra = { mult_mod = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { vars = { card.ability.extra.mult_mod } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and context.other_card.ability.effect == 'Stone Card' then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult_mod
            return { message = localize('exotic_bust_upgrade'), colour = G.C.MULT }
        end
    end
}