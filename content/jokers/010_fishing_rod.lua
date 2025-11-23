SMODS.Joker {
    key = "fishing_rod", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = false, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = { extra = { odds = 4 } },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'fishing_rod')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if not context.blueprint and context.open_booster then
            if SMODS.pseudorandom_probability(card, 'fishing_rod', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event {
                    trigger = 'after',
                    delay = 1.2,
                    func = function()
                        if G.pack_cards and #G.pack_cards.cards > 0 then
                            local random_index = pseudorandom('fishing_rod_pick', 1, #G.pack_cards.cards)
                            local selected_card = G.pack_cards.cards[random_index]
                            -- Check what type of card is being selected
                            local destination = nil
                            local can_add = false

                            if selected_card.ability.set == 'Joker' then
                                -- Check if there's room in joker slots
                                if #G.jokers.cards < G.jokers.config.card_limit then
                                    draw_card(G.pack_cards, G.jokers, 90, 'up', nil, selected_card)
                                    can_add = true
                                end
                            elseif selected_card.ability.set == 'Default' or selected_card.ability.set == 'Enhanced' then
                                -- Playing cards go directly to deck
                                -- Register as a playing card
                                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                                selected_card.playing_card = G.playing_card
                                table.insert(G.playing_cards, selected_card)
                                
                                -- Move to deck
                                draw_card(G.pack_cards, G.deck, 90, 'up', nil, selected_card)
                                SMODS.calculate_context({ playing_card_added = true, cards = { selected_card } })
                                
                                can_add = true
                            else
                                -- Consumables (Tarot, Planet, Spectral, etc.)
                                if #G.consumeables.cards < G.consumeables.config.card_limit then
                                    draw_card(G.pack_cards, G.consumeables, 90, 'up', nil, selected_card)
                                    can_add = true
                                end
                            end

                            -- Show message if card was added
                            if can_add then
                                card_eval_status_text(card, 'extra', nil, nil, nil, { 
                                    message = localize('exotic_fished_card'), 
                                    colour = G.C.GREEN 
                                })
                            end
                        end
                        return true
                    end
                })
                return nil, true
            end
        end
    end
}