SMODS.Joker {
    key = "green_muscat", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = { extra = { remaining = 3 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.remaining } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint then
            if context.full_hand and card.ability.extra.remaining > 0 then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    card.ability.extra.remaining = card.ability.extra.remaining - 1
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_chariot')
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    
                    return {
                        message = localize('exotic_plus_tarot'),
                        colour = G.C.PURPLE,
                        card = card
                    }
                end
            end
        end
    end
}
