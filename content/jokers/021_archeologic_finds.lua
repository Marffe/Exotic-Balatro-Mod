SMODS.Joker {
    key = "archeologic_finds", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = {},

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if G.GAME.current_round.hands_played == 0 then
                if context.full_hand and #context.full_hand > 0 then
                    local first_card = context.full_hand[1]
                    if first_card.config.center == G.P_CENTERS.m_stone then
                        local tag_type = 'tag_standard' -- Default
                        -- Pick a random tag
                        local tag_pool = {}
                        for k, v in pairs(G.P_TAGS) do
                            if not v.key == 'tag_double' then -- Avoid double tag loops if desired, or include it
                                table.insert(tag_pool, k)
                            end
                        end
                        if #tag_pool > 0 then
                            tag_type = tag_pool[math.random(#tag_pool)]
                        end
                        
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local tag = Tag(tag_type)
                                add_tag(tag)
                                return true
                            end
                        }))

                        return {
                            message = localize('exotic_plus_tag'),
                            colour = G.C.PURPLE,
                            card = card
                        }
                    end
                end
            end
        end
    end
}
