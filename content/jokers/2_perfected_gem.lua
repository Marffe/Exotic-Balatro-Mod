SMODS.Joker {
    key = "perfected_gem", atlas = "joker_atlas", pos = { x = 2, y = 0 }, -- Rare

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 3, cost = 8, discovered = true, unlocked = true,

    config = { extra = { xmult_base = 1, xmult_gain = 0.1, money = 8 } },
    loc_vars = function(self, info_queue, card)
        local current_xmult = card.ability.extra.xmult_base + (card.ability.extra.xmult_gain * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.money))
        return { vars = { card.ability.extra.xmult_base, card.ability.extra.xmult_gain, card.ability.extra.money, current_xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            local xmult_value = card.ability.extra.xmult_base + (card.ability.extra.xmult_gain * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.money))
            return { x_mult = xmult_value, card = card }
        end
    end,
}