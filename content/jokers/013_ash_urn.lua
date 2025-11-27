SMODS.Joker {
    key = "ash_urn", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = false,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = { extra = { chips = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        -- Trigger when cards are destroyed
        if not context.blueprint and context.remove_playing_cards and #context.removed > 0 then
            local chips_gained = 0
            -- Add up chips from all destroyed cards
            for _, v in ipairs(context.removed) do
                chips_gained = chips_gained + v:get_chip_bonus()
            end
            if chips_gained > 0 then
                card.ability.extra.chips = card.ability.extra.chips + chips_gained
                return { message = localize { type = 'variable', key = 'a_chips', vars = { chips_gained } }, colour = G.C.CHIPS }
            end
        end
        -- Apply accumulated chips during scoring
        if context.joker_main and card.ability.extra.chips > 0 then
            return { chips = card.ability.extra.chips }
        end
    end
}