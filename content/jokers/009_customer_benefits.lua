SMODS.Joker {
    key = "customer_benefits", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = { extra = { money_spent = 0, required_spent = 15, free_reroll_active = false } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.required_spent, card.ability.extra.money_spent, card.ability.extra.required_spent - card.ability.extra.money_spent } }
    end,

    calculate = function(self, card, context)
        -- Check for money spend
        if context.buying_card or context.reroll_shop then
            local cost = 0
            -- When buying
            if context.buying_card and context.card then
                cost = context.card.cost or 0
            end
            -- When spending in a reroll
            if context.reroll_shop and not card.ability.extra.free_reroll_active then
                cost = G.GAME.current_round.reroll_cost or 0
            end
            -- total spend
            if cost > 0 then
                card.ability.extra.money_spent = card.ability.extra.money_spent + cost
                -- Umbral reached
                if card.ability.extra.money_spent >= card.ability.extra.required_spent then
                    card.ability.extra.money_spent = card.ability.extra.money_spent - card.ability.extra.required_spent
                    card.ability.extra.free_reroll_active = true
                    SMODS.change_free_rerolls(1)
                    return { message = localize('exotic_customer_benefits'), colour = G.C.MONEY, card = card }
                end
            end
        end
        
        -- Resets the loop
        if context.reroll_shop and card.ability.extra.free_reroll_active then
            card.ability.extra.free_reroll_active = false
            SMODS.change_free_rerolls(-1)
        end
    end,

    -- Clean Up the store if free reroll is not used
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.money_spent = 0
        card.ability.extra.free_reroll_active = false
    end,

    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.free_reroll_active then
            SMODS.change_free_rerolls(-1)
            card.ability.extra.free_reroll_active = false
        end
    end
}