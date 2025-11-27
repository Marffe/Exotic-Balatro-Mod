SMODS.Joker {
    key = "shift_change", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 4, discovered = true, unlocked = true,

    config = { extra = { mult = 20, current_rank = 'Ace' } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.current_rank, 'ranks') } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local rank_matches = false
            if context.scoring_hand then
                for _, scoring_card in ipairs(context.scoring_hand) do
                    if scoring_card.base.value == card.ability.extra.current_rank then
                        rank_matches = true
                        break
                    end
                end
            end

            if rank_matches then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult,
                    card = card
                }
            end
        end

        if context.cardarea == G.jokers and context.after and not context.blueprint then
            local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'}
            local current_index = 0
            for i, r in ipairs(ranks) do
                if r == card.ability.extra.current_rank then
                    current_index = i
                    break
                end
            end
            
            local next_index = current_index + 1
            if next_index > #ranks then next_index = 1 end
            card.ability.extra.current_rank = ranks[next_index]
        end
    end
}
