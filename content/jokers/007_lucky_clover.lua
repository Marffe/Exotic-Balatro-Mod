SMODS.Joker {
    key = "lucky_clover", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,


    config = { extra = { odds = 4 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { '' .. (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            local is_club_flush = false
            local hand_type = context.scoring_name or ''
            if hand_type == 'Flush' or hand_type == 'Straight Flush' or hand_type == 'Flush House' or hand_type == 'Flush Five' then
                local clubs_count = 0
                local total_cards = 0
                if context.full_hand then
                    for i = 1, #context.full_hand do
                        local scoring_card = context.full_hand[i]
                        total_cards = total_cards + 1
                        if scoring_card.base.suit == 'Clubs' or scoring_card.ability.name == 'Wild Card' then
                            clubs_count = clubs_count + 1
                        end
                    end
                end
                local min_cards = 5
                if next(find_joker('Four Fingers')) then
                    min_cards = 4
                end

                if total_cards >= min_cards and clubs_count >= min_cards then
                    is_club_flush = true
                end
            end

            if is_club_flush then
                if pseudorandom('clover_path') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        
                        return {
                            extra = {
                                focus = card,
                                message = localize('exotic_lucky_clover'), colour = G.C.SECONDARY_SET.Tarot,
                                func = function()
                                    G.E_MANAGER:add_event(Event({
                                        delay = 0.0,
                                        func = function()
                                            local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_magician')
                                            new_card:add_to_deck()
                                            G.consumeables:emplace(new_card)
                                            G.GAME.consumeable_buffer = 0
                                            return true
                                        end
                                    }))
                                end
                            },
                            colour = G.C.SECONDARY_SET.Tarot,
                            card = card
                        }
                    end
                end
            end
        end
    end
}