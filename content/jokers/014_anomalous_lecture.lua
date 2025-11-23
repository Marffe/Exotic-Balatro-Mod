SMODS.Joker {
    key = "anomalous_lecture", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 4, discovered = true, unlocked = true,

    config = { 
        extra = { } 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}