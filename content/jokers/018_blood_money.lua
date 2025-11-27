SMODS.Joker {
    key = "blood_money", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = { extra = { count = 0, rounds_needed = 2 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_hanged_man
        info_queue[#info_queue + 1] = G.P_CENTERS.c_devil
        return { vars = { card.ability.extra.rounds_needed, card.ability.extra.count % card.ability.extra.rounds_needed } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.count = card.ability.extra.count + 1
            
            if card.ability.extra.count % card.ability.extra.rounds_needed == 0 then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    
                    -- Randomly choose between The Hanged Man or The Devil
                    local tarot_key = pseudorandom('blood_money') < 0.5 and 'c_hanged_man' or 'c_devil'
                    
                    return {
                        extra = {
                            focus = card,
                            message = "hehe",
                            colour = G.C.SECONDARY_SET.Tarot,
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    delay = 0.0,
                                    func = function()
                                        local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, tarot_key)
                                        new_card:add_to_deck()
                                        G.consumeables:emplace(new_card)
                                        G.GAME.consumeable_buffer = 0
                                        card:juice_up()
                                        return true
                                    end
                                }))
                            end
                        },
                        colour = G.C.SECONDARY_SET.Tarot, card = card
                    }
                end
            end
        end
    end,
}