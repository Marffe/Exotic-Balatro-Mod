SMODS.Joker {
    key = "power_spike", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = false,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = { extra = { xmult = 1, xmult_mod = 0.1 } },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
    end,
    
    in_pool = function(self)
        -- Only appear in pool if there are mult cards in the deck
        for _, v in pairs(G.playing_cards) do
            if v.config.center.key == "m_mult" then
                return true
            end
        end
        return false
    end,
    
    calculate = function(self, card, context) -- Here is where it checks for mult cards
        if context.before and not context.blueprint then
            local multi_cards = 0
            for _, v in ipairs(context.full_hand) do
                if v.config.center.key == "m_mult" then
                    multi_cards = multi_cards + 1
                end
            end
            if multi_cards > 0 then -- and here applies the scale upgrade and send a custom message
                card.ability.extra.xmult = card.ability.extra.xmult + (card.ability.extra.xmult_mod * multi_cards)
                return { message = localize('exotic_electric_upgrade'), colour = G.C.MULT, card = card }
            end
        end

        if context.joker_main then -- Scoring part
            return { xmult = card.ability.extra.xmult }
        end
        return nil
    end
}