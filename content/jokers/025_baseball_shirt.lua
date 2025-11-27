SMODS.Joker {
    key = "baseball_shirt", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = { extra = { cards_to_convert = 3 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards_to_convert } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if G.GAME.current_round.hands_played == 0 then
                if context.full_hand and #context.full_hand > 0 then
                    local first_card = context.full_hand[1]
                    local target_suit = first_card.base.suit
                    
                    local available_cards = {}
                    for _, c in ipairs(G.playing_cards) do
                        if c.base.suit ~= target_suit then
                            table.insert(available_cards, c)
                        end
                    end

                    if #available_cards > 0 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                for i = 1, card.ability.extra.cards_to_convert do
                                    if #available_cards == 0 then break end
                                    local rand_index = math.random(#available_cards)
                                    local card_to_change = available_cards[rand_index]
                                    table.remove(available_cards, rand_index)
                                    
                                    card_to_change:change_suit(target_suit)
                                    card_to_change:juice_up()
                                end
                                return true
                            end
                        }))
                        
                        return {
                            message = localize('exotic_active_ex'),
                            colour = G.C.SECONDARY_SET.Suit,
                            card = card
                        }
                    end
                end
            end
        end
    end
}
