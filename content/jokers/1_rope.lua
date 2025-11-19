SMODS.Joker {
    key = "rope", atlas = "joker_atlas", pos = { x = 2, y = 0 }, -- Rare

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 3, cost = 5, discovered = true, unlocked = true,

    config = { extra = { chipsgain = 50, chips = 50 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chipsgain, card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss then
            -- See note about SMODS Scaling Manipulation on the wiki, nah, I'm leaving this here
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chipsgain
            return { message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } } }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}