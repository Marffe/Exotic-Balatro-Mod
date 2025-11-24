SMODS.Back {
    key = "spiked_deck", atlas = "joker_atlas", pos = { x = 4, y = 2 },

    config = { },

    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.discards, localize { type = 'name_text', key = 'c_hanged_man', set = 'Tarot' } } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and context.main_eval then
            -- Create 2 Hanged Man cards
            for i = 1, 2 do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3 * i,
                    func = function()
                        local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_hanged_man')
                        new_card:add_to_deck()
                        G.consumeables:emplace(new_card)
                        return true
                    end
                }))
            end
        end
    end
}