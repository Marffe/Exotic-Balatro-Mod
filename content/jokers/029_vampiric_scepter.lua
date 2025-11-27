SMODS.Joker {
    key = "vampiric_scepter", atlas = "joker_atlas", pos = { x = 2, y = 0 }, -- Rare

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 3, cost = 8, discovered = true, unlocked = true,

    config = { extra = { mult = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}
            }
        end

        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if G.GAME.current_round.hands_played == 0 then
                if context.full_hand and #context.full_hand > 0 then
                    local first_card = context.full_hand[1]
                    
                    -- Debuff forever (custom logic needed for persistence, but for now standard debuff)
                    -- To make it permanent, we might need to store it in the card's ability or a global table
                    -- For this implementation, we'll set a custom flag and hook Card:set_debuff
                    first_card.ability.perma_debuff = true
                    first_card:set_debuff(true)

                    local mult_gain = 0
                    if first_card.base.value == 'Stone' or not first_card.base.nominal then -- Rankless check
                         mult_gain = 20
                    else
                         mult_gain = 2 * first_card.base.nominal -- Using nominal chips as approximation of "Card Chips"
                         -- Or use first_card:get_chip_bonus() + first_card.base.nominal?
                         -- "X2 times his chips" usually means base chips + bonus chips
                         mult_gain = 2 * (first_card.base.nominal + (first_card.ability.bonus or 0))
                    end

                    card.ability.extra.mult = card.ability.extra.mult + mult_gain
                    
                    return {
                        message = localize('exotic_upgrade_ex'),
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end
        end
    end
}

-- Hook for permanent debuff
local card_set_debuff_ref = Card.set_debuff
function Card:set_debuff(should_debuff)
    if self.ability and self.ability.perma_debuff then
        should_debuff = true
    end
    return card_set_debuff_ref(self, should_debuff)
end
