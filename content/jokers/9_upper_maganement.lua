SMODS.Joker {
    key = "upper_management", atlas = "joker_atlas", pos = { x = 0, y = 0 }, -- Common

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 1, cost = 5, discovered = true, unlocked = true,

    config = { extra = { chips = 40, mult = 8, last_ante = -1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.cardarea ~= G.jokers then return end
        if context.joker_main then
            return { chips = card.ability.extra.chips, mult = card.ability.extra.mult, }
        end

        -- Played cards are debuffed (Because you mess up something)
        if context.before and G.GAME.current_round.hands_left > 1 then
            for i = 1, #context.scoring_hand do
                local scored_card = context.scoring_hand[i]
                SMODS.debuff_card(scored_card, true, 'upper_management')
            end
        end

        -- Played cards are activeted again when you have only 1 hand (Because the HR Office will mess up something)
        if context.before and G.GAME.current_round.hands_left == 1 then
            for _, pcard in pairs(G.playing_cards) do
                SMODS.debuff_card(pcard, false, 'upper_management')
            end
        end

        -- Clean debuff after the Boos Blind, this is made so you can play with on hand effects
        if context.end_of_round and G.GAME.blind.boss and not context.blueprint then
            local current_ante = G.GAME.round_resets.ante or 1
            if current_ante > card.ability.extra.last_ante then
                card.ability.extra.last_ante = current_ante
                for _, pcard in pairs(G.playing_cards) do
                    SMODS.debuff_card(pcard, false, 'upper_management')
                end
            end
        end
    end,

    -- Remove debuffs if sold
    remove_from_deck = function(self, card, from_debuff)
        for _, pcard in pairs(G.playing_cards) do
            SMODS.debuff_card(pcard, false, 'upper_management')
        end
    end,
}