SMODS.Back {
    key = "obelisk_deck", atlas = "joker_atlas", pos = { x = 4, y = 2 },

    config = { Xmult = 1, Xmult_gain = 0.1 },

    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = 1.5
        -- Initialize global tracking variable
        G.GAME.obelisk_last_hand = G.GAME.obelisk_last_hand or "None"
    end,

    loc_vars = function(self, info_queue, back)
        -- Safely get the last hand from global game state
        local last_hand = G.GAME.obelisk_last_hand or "None"

        -- Get current Xmult from deck state or use default
        local state = back and back.effect and back.effect.config
        local current_xmult = (state and state.Xmult) or self.config.Xmult

        return { vars = { current_xmult, self.config.Xmult_gain, last_hand } }
    end,

    calculate = function(self, back, context)
        if context.final_scoring_step then
            local state = back.effect.config
            local current_hand = context.scoring_name

            if G.GAME.obelisk_last_hand == current_hand then
                state.Xmult = state.Xmult / 2
                if state.Xmult < 1 then state.Xmult = 1 end
            else
                state.Xmult = state.Xmult + state.Xmult_gain
            end
            G.GAME.obelisk_last_hand = current_hand
            return { xmult = state.Xmult }
        end
    end
}