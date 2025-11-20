SMODS.Joker {
    key = "supportive_joker", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = { extra = { score_chips = 0, extra_chips = 2 } },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.extra_chips, card.ability.extra.score_chips } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local unscored_cards = #context.full_hand - #context.scoring_hand
            card.ability.extra.score_chips = card.ability.extra.score_chips + (unscored_cards * card.ability.extra.extra_chips)
        end
        if context.joker_main then
            if card.ability.extra.score_chips > 0 then
                return { chips = card.ability.extra.score_chips, }
            end
        end
    end
}