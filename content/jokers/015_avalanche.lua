SMODS.Joker {
    key = "avalanche", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 5, discovered = true, unlocked = true,

    config = { extra = { accumulated_chips = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.accumulated_chips } }
    end,

    calculate = function(self, card, context)
        -- Reset accumulated chips at the start of scoring
        if context.before and not context.blueprint then
            card.ability.extra.accumulated_chips = 0
        end

        -- Add chips during individual card scoring
        if context.individual and context.cardarea == G.play then
            local bonus_chips = card.ability.extra.accumulated_chips
            
            -- Add current card's chips to accumulator for next cards
            if not context.blueprint then
                card.ability.extra.accumulated_chips = card.ability.extra.accumulated_chips + context.other_card:get_chip_bonus()
            end

            -- Return bonus chips if any accumulated
            if bonus_chips > 0 then
                return { chips = bonus_chips, card = card }
            end
        end

        -- Reset at end of round
        if context.end_of_round and not context.blueprint then
            card.ability.extra.accumulated_chips = 0
        end
    end,
}