SMODS.Back {
    key = "obelisk_deck", atlas = "joker_atlas", pos = { x = 4, y = 2 },

    config = { Xmult = 1, Xmult_gain = 0.1, last_hand = nil },

    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = 1.5
    end,

    loc_vars = function(self, info_queue, back)
        -- 1. Get the current runtime state safely
        local state = back and back.effect and back.effect.config
        local current_xmult = (state and state.Xmult) or self.config.Xmult
        local last_hand = (state and state.last_hand) or "None"

        return { vars = { current_xmult, self.config.Xmult_gain, last_hand } }
    end,

    calculate = function(self, back, context)
        if context.final_scoring_step then
            local state = back.effect.config
            local current_hand = context.scoring_name

            -- Check Consecutive Hands
            if state.last_hand == current_hand then
                state.Xmult = state.Xmult / 2
                if state.Xmult < 1 then state.Xmult = 1 end
            else
                state.Xmult = state.Xmult + state.Xmult_gain
            end
            -- Update the last_hand
            state.last_hand = current_hand
            -- Apply: Return the Xmult
            return { xmult = state.Xmult }
        end
    end
}