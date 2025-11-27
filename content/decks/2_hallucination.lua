SMODS.Back {
    key = "hallucination", 
    atlas = "joker_atlas", 
    pos = { x = 4, y = 2 },
    
    config = { },
    
    loc_vars = function(self, info_queue, back)
        return { vars = { } }
    end,
    
    -- Set the flag when the deck is applied
    apply = function(self) 
        G.GAME.hallucination_deck = true
    end,
    
    calculate = function(self, back, context)
        if context.open_booster and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local card = create_card('Consumeables', G.consumeables, nil, nil, nil, nil, nil, 'hallucination_reward')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            return {
                message = localize('k_plus_consumable'),
                colour = G.C.PURPLE,
            }
        end
    end
}