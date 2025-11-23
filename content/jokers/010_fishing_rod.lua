SMODS.Joker {
    key = "fishing_rod", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = { 
        extra = { } 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}