SMODS.Joker {
    key = "five_finger_fillet", atlas = "joker_atlas", pos = { x = 2, y = 0 }, -- Rare

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 3, cost = 8, discovered = true, unlocked = true,

    config = { extra = { money_per_hand = 0, money_gain = 2, odds = 5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money_per_hand, card.ability.extra.money_gain, G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            if pseudorandom('five_finger_fillet') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.current_round.hands_left = 1
                        return true
                    end
                }))
                return {
                    message = localize('exotic_oh_no'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end

        if context.cardarea == G.jokers and context.before and not context.blueprint then
            card.ability.extra.money_per_hand = card.ability.extra.money_per_hand + card.ability.extra.money_gain
            return {
                message = localize('exotic_upgrade_ex'),
                colour = G.C.MONEY,
                card = card
            }
        end

        if context.end_of_round and not context.repetition and not context.blueprint then
            if G.GAME.blind.boss then
                card.ability.extra.money_per_hand = 0
                return {
                    message = localize('exotic_reset'),
                    colour = G.C.RED,
                    card = card
                }
            else
                local money_gain = G.GAME.current_round.hands_played * card.ability.extra.money_per_hand
                if money_gain > 0 then
                    ease_dollars(money_gain)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+"..localize('$')..money_gain, colour = G.C.MONEY})
                end
            end
        end
    end
}
