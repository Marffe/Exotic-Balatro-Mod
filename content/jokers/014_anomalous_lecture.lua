SMODS.Joker {
    key = "anomalous_lecture", 
    atlas = "joker_atlas", 
    pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = { extra = { chips = 0, mult = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        -- Trigger when selecting a blind (only once, not during blueprint)
        if context.setting_blind and not context.blueprint and not card.getting_sliced then
            -- Find a planet card in consumables
            local planet_card = nil
            for _, c in ipairs(G.consumeables.cards) do
                if c.ability.set == 'Planet' then
                    planet_card = c
                    break
                end
            end

            -- If we found a planet card, destroy it and gain its stats
            if planet_card then
                -- Get the hand type that this planet upgrades
                local hand_type = planet_card.ability.hand_type
                
                -- Get the level-up values from the game's hand data
                local chips_gain = hand_type and G.GAME.hands[hand_type] and G.GAME.hands[hand_type].l_chips or 0
                local mult_gain = hand_type and G.GAME.hands[hand_type] and G.GAME.hands[hand_type].l_mult or 0

                -- Randomly choose which stat to gain (50/50 chance)
                local gained_stat = ""
                local gained_value = 0
                local stat_color = G.C.CHIPS

                if pseudorandom('anomalous_lecture') < 0.5 then
                    -- Gain mult (doubled)
                    if mult_gain > 0 then
                        local doubled_mult = mult_gain * 2
                        card.ability.extra.mult = card.ability.extra.mult + doubled_mult
                        gained_stat = "mult"
                        gained_value = doubled_mult
                        stat_color = G.C.MULT
                    end
                else
                    -- Gain chips (doubled)
                    if chips_gain > 0 then
                        local doubled_chips = chips_gain * 2
                        card.ability.extra.chips = card.ability.extra.chips + doubled_chips
                        gained_stat = "chips"
                        gained_value = doubled_chips
                        stat_color = G.C.CHIPS
                    end
                end

                -- Create the animation and destruction event
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card:juice_up(0.3, 0.5)
                        planet_card:juice_up(0.3, 0.5)
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        planet_card:start_dissolve()
                        return true
                    end
                }))

                -- Return appropriate message
                if gained_value > 0 then
                    return { message = localize { type = 'variable', key = gained_stat == "mult" and 'a_mult' or 'a_chips', vars = { gained_value } }, colour = stat_color, card = card }
                end
            end
        end

        -- Apply accumulated chips during scoring
        if context.joker_main then
            local result = {}
            if card.ability.extra.chips > 0 then
                result.chips = card.ability.extra.chips
            end
            if card.ability.extra.mult > 0 then
                result.mult = card.ability.extra.mult
            end
            if next(result) then
                return result
            end
        end
    end
}