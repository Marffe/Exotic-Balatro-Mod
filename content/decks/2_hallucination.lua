SMODS.Back {
    key = "hallucination", atlas = "joker_atlas", pos = { x = 4, y = 2 },

    config = { discards = 1 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.discards } }
    end,
}