SMODS.Joker {
    key = "cooler_joker", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = false,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = { extra = { mult = 3, cooler_mult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cooler_mult, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            if SMODS.last_hand_oneshot and not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.cooler_mult
                return { message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }, colour = G.C.MULT, card = card }
            end
        end
        if context.joker_main then return { mult = card.ability.extra.mult } end
    end,
}