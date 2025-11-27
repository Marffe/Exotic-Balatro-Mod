SMODS.Joker {
    key = "the_offerings", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = { extra = { cards_required = 4, current_count = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current_count, card.ability.extra.cards_required } }
    end,

    calculate = function(self, card, context)
        -- Logic moved to hook
    end
}

local card_start_dissolve_ref = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    local offerings = SMODS.find_card('j_exotic_the_offerings')
    if offerings and #offerings > 0 then
        for _, card in ipairs(offerings) do
            card.ability.extra.current_count = card.ability.extra.current_count + 1
            if card.ability.extra.current_count >= card.ability.extra.cards_required then
                local creations = math.floor(card.ability.extra.current_count / card.ability.extra.cards_required)
                card.ability.extra.current_count = card.ability.extra.current_count % card.ability.extra.cards_required
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = 1, creations do
                            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                                local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_death')
                                new_card:add_to_deck()
                                G.consumeables:emplace(new_card)
                                G.GAME.consumeable_buffer = 0
                            end
                        end
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('exotic_plus_tarot'), colour = G.C.PURPLE})
                        return true
                    end
                }))
            end
        end
    end
    return card_start_dissolve_ref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end
