SMODS.Joker {
    key = "spectral_call", atlas = "joker_atlas", pos = { x = 2, y = 0 }, -- Rare

    blueprint_compat = true, eternal_compat = true, perishable_compat = false,
    rarity = 3, cost = 7, discovered = true, unlocked = true,

    config = { extra = { xmult = 1, extra_xmult = 0.5 } },

    loc_vars = function(self, info_queue, card)
        local spectral_count = G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0
        local total_xmult = 1 + (card.ability.extra.extra_xmult * spectral_count)
        return { vars = { card.ability.extra.extra_xmult, spectral_count, total_xmult } }
    end,

    calculate = function(self, card, context)
        -- Increment when spectral card is used
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Spectral" then
            return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.extra_xmult } }, colour = G.C.XMULT }
        end
        -- Apply XMult during scoring
        if context.joker_main then
            local spectral_count = G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0
            if spectral_count > 0 then
                local total_xmult = card.ability.extra.xmult + (card.ability.extra.extra_xmult * spectral_count)
                return { xmult = total_xmult, card = card }
            end
        end
    end,
}