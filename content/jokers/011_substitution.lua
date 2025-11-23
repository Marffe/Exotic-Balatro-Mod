SMODS.Joker {
    key = "substitution", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = false, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = { 
        extra = {
            active = false
        } 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    calculate = function(self, card, context)
        -- Mark as active when exactly 1 card is discarded
        if context.pre_discard and not context.hook and #context.full_hand == 1 then
            card.ability.extra.active = true
        end

        -- Draw extra card of most common rank (only after discard, not on blind selection)
        if context.drawing_cards and card.ability.extra.active and G.GAME.current_round.discards_used > 0 then
            -- Count ranks in deck
            local rank_counts = {}
            for _, deck_card in pairs(G.deck.cards) do
                local rank = deck_card.base.value
                if not SMODS.has_no_rank(deck_card) then
                    rank_counts[rank] = (rank_counts[rank] or 0) + 1
                end
            end

            -- Create sorted list of ranks by count
            local ranks_by_count = {}
            for rank, count in pairs(rank_counts) do
                table.insert(ranks_by_count, {rank = rank, count = count})
            end
            table.sort(ranks_by_count, function(a, b) return a.count > b.count end)

            -- If we found ranks, find and draw a card of that rank
            if #ranks_by_count > 0 then
                local most_common_rank = ranks_by_count[1].rank
                
                -- Find a card of the most common rank in the deck
                local target_card = nil
                for _, deck_card in pairs(G.deck.cards) do
                    if deck_card.base.value == most_common_rank then
                        target_card = deck_card
                        break
                    end
                end

                -- Draw the specific card if found
                if target_card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            draw_card(G.deck, G.hand, 100, 'up', nil, target_card)
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = localize(most_common_rank, 'ranks'),
                                colour = G.C.BLUE
                            })
                            return true
                        end
                    }))
                end
            end
        end

        -- Reset active state after drawing
        if context.hand_drawn then
            card.ability.extra.active = false
        end
    end
}