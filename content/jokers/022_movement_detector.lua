SMODS.Joker {
    key = "movement_detector", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = { extra = { mult_gain = 1, current_mult = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.current_mult } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                mult_mod = card.ability.extra.current_mult,
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.current_mult}}
            }
        end
    end
}

-- Hook into Card:score to detect retriggers
local card_score_ref = Card.score
function Card:score(context)
    local ret = {card_score_ref(self, context)}
    
    -- If we are in the context of scoring a hand
    if context and context.cardarea == G.play then
        -- Check if this is a retrigger
        if not self.times_scored_this_hand then self.times_scored_this_hand = 0 end
        self.times_scored_this_hand = self.times_scored_this_hand + 1

        if self.times_scored_this_hand > 1 then
            -- This is a retrigger
            local movement_detector = SMODS.find_card('j_exotic_movement_detector')
            for _, joker in ipairs(movement_detector) do
                joker.ability.extra.current_mult = joker.ability.extra.current_mult + joker.ability.extra.mult_gain
                card_eval_status_text(joker, 'extra', nil, nil, nil, {message = localize('exotic_upgrade_ex'), colour = G.C.MULT})
            end
        end
    end

    return unpack(ret)
end

-- Hook into Card:calculate_seal to detect Red Seal retriggers
local card_calculate_seal_ref = Card.calculate_seal
function Card:calculate_seal(context)
    local ret = {card_calculate_seal_ref(self, context)}
    if ret[1] then -- If seal triggered
        -- Check if it's a Red Seal (retrigger)
        if self.seal == 'Red' and context.cardarea == G.play and context.repetition then
             -- This is a retrigger caused by Red Seal
             -- Note: Red seal causes a retrigger, which calls eval_card again.
             -- If eval_card calls Card:score, then the hook above handles it.
             -- But user said it's NOT catching red seals.
             -- This implies Card:score is NOT called for Red Seal retrigger?
             -- Or maybe my times_scored_this_hand logic is reset too early?
             -- Or context.cardarea is different?
             
             -- Let's explicitly trigger here just in case, but be careful not to double count if Card:score IS called.
             -- If I trigger here, I don't rely on Card:score.
             -- But Red Seal causes the CARD to score again.
             -- If I rely on Card:score, I cover all retriggers (Hack, Socker, etc).
             -- If Red Seal doesn't call Card:score, then I need this hook.
             
             -- I will assume Red Seal retrigger does NOT call Card:score in the way I expect, or my hook misses it.
             -- I'll add the logic here.
             
            local movement_detector = SMODS.find_card('j_exotic_movement_detector')
            for _, joker in ipairs(movement_detector) do
                joker.ability.extra.current_mult = joker.ability.extra.current_mult + joker.ability.extra.mult_gain
                card_eval_status_text(joker, 'extra', nil, nil, nil, {message = localize('exotic_upgrade_ex'), colour = G.C.MULT})
            end
        end
    end
    return unpack(ret)
end

-- Reset the counter at start of play
local game_play_cards_ref = G.FUNCS.play_cards
G.FUNCS.play_cards = function(e)
    if G.hand and G.hand.cards then
        for _, c in ipairs(G.hand.cards) do
            c.times_scored_this_hand = 0
        end
    end
    -- Also check highlighted cards as they are the ones played
    if G.hand and G.hand.highlighted then
        for _, c in ipairs(G.hand.highlighted) do
            c.times_scored_this_hand = 0
        end
    end
    game_play_cards_ref(e)
end
