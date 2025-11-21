SMODS.Joker {
    key = "top_quality", atlas = "joker_atlas", pos = { x = 2, y = 0 }, -- Rare

    blueprint_compat = true, eternal_compat = true, perishable_compat = false,
    rarity = 3, cost = 8, discovered = true, unlocked = true,

    config = { extra = { mult = 0, mult_mod = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if #context.full_hand == 2 then
                local is_pair_of_tens = true
                for _, v in ipairs(context.full_hand) do
                    if v:get_id() ~= 10 then
                        is_pair_of_tens = false
                        break
                    end
                end
                if is_pair_of_tens then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    return { message = localize('exotic_top_qaulity_upgrade'), colour = G.C.MULT, card = card }
                end
            end
        end
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
        return nil
    end
}