SMODS.Joker {
    key = "necklace", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 6, discovered = true, unlocked = true,

    config = {},

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}

-- Override Card.set_debuff to prevent Diamonds from being debuffed
local set_debuff_ref = Card.set_debuff
function Card:set_debuff(should_debuff)
    -- Check if Necklace joker is in play
    local has_necklace = next(SMODS.find_card('j_exotic_necklace'))
    -- If this is a Diamond card and Necklace is active, don't debuff it
    if has_necklace and self:is_suit('Diamonds') then
        self.debuff = false
        return
    end
    -- Otherwise use the normal debuff logic
    return set_debuff_ref(self, should_debuff)
end

-- Override Blind.stay_flipped to prevent Diamonds from staying flipped
local stay_flipped_ref = Blind.stay_flipped
function Blind:stay_flipped(area, card)
    -- Check if Necklace joker is in play
    local has_necklace = next(SMODS.find_card('j_exotic_necklace'))
    -- If this is a Diamond card and Necklace is active, don't keep it flipped
    if has_necklace and card:is_suit('Diamonds') then
        return false
    end
    -- Otherwise use the normal flip logic
    return stay_flipped_ref(self, area, card)
end
