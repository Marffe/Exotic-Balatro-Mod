SMODS.Joker {
    key = "tree_plum", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = { extra = { rounds_left = 4 } },

    loc_vars = function(self, info_queue, card)
        local plural = card.ability.extra.rounds_left == 1 and "" or "s"
        local plural_espanol = card.ability.extra.rounds_left == 1 and "en" or "por"
        return { vars = { card.ability.extra.rounds_left, plural, plural_espanol } }
    end,

    calculate = function(self, card, context)
        -- Trigger at the start of the round
        if context.setting_blind and not context.blueprint then
            -- Check how many consumable slots are available
            local available_slots = G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)
            
            if available_slots > 0 then
                -- Fill all available slots with random tarot cards
                for i = 1, available_slots do
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.2 * i, -- Stagger the creation for visual effect
                        func = function()
                            local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'tree_plum')
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                            return true
                        end
                    }))
                end
                
                -- Decrease rounds counter
                card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
                
                -- Check if joker should be destroyed
                if card.ability.extra.rounds_left < 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after', 
                                delay = 0.3, 
                                blockable = false,
                                func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    
                    return {
                        message = localize('k_extinct_ex'),
                        colour = G.C.FILTER
                    }
                else
                    return {
                        message = localize { type = 'variable', key = 'a_remaining', vars = { card.ability.extra.rounds_left } },
                        colour = G.C.SECONDARY_SET.Tarot
                    }
                end
            else
                -- No slots available, still decrease counter
                card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
                
                if card.ability.extra.rounds_left < 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after', 
                                delay = 0.3, 
                                blockable = false,
                                func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    
                    return {
                        message = localize('k_extinct_ex'),
                        colour = G.C.FILTER
                    }
                end
            end
        end
    end
}