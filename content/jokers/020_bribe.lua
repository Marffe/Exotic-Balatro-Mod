SMODS.Joker {
    key = "bribe", atlas = "joker_atlas", pos = { x = 2, y = 0 }, -- Rare

    blueprint_compat = false, eternal_compat = true, perishable_compat = true,
    rarity = 3, cost = 8, discovered = true, unlocked = true,

    config = { extra = { cost = 5, cost_increase = 5, threshold = 25 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cost, card.ability.extra.cost_increase, card.ability.extra.threshold } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            if G.GAME.blind.boss and not G.GAME.blind.disabled then
                if G.GAME.dollars >= card.ability.extra.threshold then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            ease_dollars(-card.ability.extra.cost)
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "-"..localize('$')..card.ability.extra.cost, colour = G.C.MONEY})
                            G.GAME.blind:disable()
                            card.ability.extra.cost = card.ability.extra.cost + card.ability.extra.cost_increase
                            card.ability.extra.threshold = card.ability.extra.threshold + card.ability.extra.cost_increase
                            return true
                        end
                    }))
                    return {
                        message = localize('exotic_active_ex'),
                        colour = G.C.FILTER
                    }
                end
            end
        end
    end
}
