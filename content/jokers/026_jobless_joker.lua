SMODS.Joker {
    key = "jobless_joker", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = {},

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint then
            if context.full_hand then
                local cards_to_destroy = {}
                for _, played_card in ipairs(context.full_hand) do
                    if played_card.debuff then
                        table.insert(cards_to_destroy, played_card)
                    end
                end

                if #cards_to_destroy > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            for _, c in ipairs(cards_to_destroy) do
                                c:start_dissolve()
                            end
                            return true
                        end
                    }))
                    
                    return {
                        message = localize('exotic_destroyed_ex'),
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end
    end
}
