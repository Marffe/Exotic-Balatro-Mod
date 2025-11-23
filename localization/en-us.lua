return {
    descriptions = {
        Back = {
            -- 1 Strategist Deck
            b_exotic_strategist = {
                name = "Strategist Deck",
                text = {
                    "{C:attention}+#1#{} Hand size",
                    "outside of Blinds and",
                    "{C:attention}+1{} extra selection",
                    "from {C:attention}Booster Packs{}",
                },
            },
            -- 2 Hallucinations Deck
            b_exotic_hallucination = {
                name = "Hallucinations Deck",
                text = {
                    "Creates a random",
                    "consumable when opening",
                    "{C:attention}Booster Packs{}.",
                    "",
                    "{C:attention}Booster Packs{}",
                    "are randomized"
                },
            },
            -- 3 Deck of Fortune
            b_exotic_deck_o_fortune = {
                name = "Deck of Fortune",
                text = {
                    "{C:green}#1# in 8{} chance of giving",
                    "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}",
                    "or {C:dark_edition}Polychrome{} to",
                    "scored cards",
                    "",
                    "Sometimes consumables",
                    "{C:red,E:2}fail{} to activate",
                },
            },
        },
        -- Blind = {},
        -- Edition = {},
        -- Enhanced = {},
        Joker = {
            -- Rope
            j_exotic_rope = {
                name = "Rope",
                text = {
                    "Gains {C:blue}+#1#{} Chips",
                    "before entering the",
                    "{C:attention}Boss Blind{}",
                    "{C:inactive}(Currently {C:chips}+#2#{} {C:inactive}chips)"
                },
            },
            -- Perfected Gem
            j_exotic_perfected_gem = {
                name = "Perfected Gem",
                text = {
                    "{C:diamonds}Diamonds{} give {X:red,C:white}X#4#{} Mult when",
                    "scored increases by {X:red,C:white}X#2#{} for",
                    "every {C:money}$#3#{} you have",
                },
            },
            -- Bust
            j_exotic_bust = {
                name = "Bust",
                text = {
                    "{C:attention}Stone Cards{} gain",
                    "{C:mult}+3{} mult when scored"
                },
            },
            -- Top Quality
            j_exotic_top_quality = {
                name = "Top Quality",
                text = {
                    "Gain {C:mult}+#1#{} mult if",
                    "played hand is exactly",
                    "a {C:attention}Pair{} of {C:attention}10s{}",
                    "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}mult)"
                },
            },
            -- Power Spike
            j_exotic_power_spike = {
                name = "Power Spike",
                text = {
                    "Gain {X:red,C:white}X#1#{} mult for",
                    "each {C:attention}Mult Card{} in",
                    "played hand",
                    "{C:inactive}(Currently {X:red,C:white}X#2#{} {C:inactive}mult)"
                },
            },
            -- Cooler Joker
            j_exotic_cooler_joker = {
                name = "Cooler Joker",
                text = {
                    "{C:red}+#2#{} mult,",
                    "gain {C:red}+#1#{} if the",
                    "{C:attention}score{} catches {C:red,E:1}fire{}",
                    "{C:inactive}(Currently {C:red}+#2#{} {C:inactive}mult)"
                },
            },
            -- Supportive Joker
            j_exotic_supportive_joker = {
                name = "Supportive Joker",
                text = {
                    "Gain {C:blue}+#1#{} Chips for",
                    "each {C:attention}unscored{} card",
                    "in played hand",
                    "{C:inactive}(Currently {C:blue}+#2#{} {C:inactive}Chips)"
                },
            },
            -- Lucky Clover
            j_exotic_lucky_clover = {
                name = "Lucky Clover",
                text = {
                    "{C:clubs}Club{} {C:attention}Flushes{} have",
                    "{C:green}#1# in #2#{} chance of",
                    "creating {C:Tarot}The Magician{}",
                },
            },
            -- Upper Management
            j_exotic_upper_management = {
                name = "Upper Management",
                text = {
                    "{C:blue}+#1#{} Chips and {C:red}+#2#{} Mult, played",
                    "cards are {C:red}debuffed{} until",
                    "you win the {C:attention}Ante{}",
                    "{C:inactive,s:0.8}(Removes the debuff if you sell it{}",
                },
            },
            -- Customer Benefits
            j_exotic_customer_benefits = {
                name = "Customer Benefits",
                text = {
                    "Gain a free {C:green}reroll{}",
                    "every {C:money}#1#${} {C:inactive}(#2#/15){} spend",
                },
            },
            -- Fishing rod
            j_exotic_fishing_rod = {
                name = "Fishing rod",
                text = {
                    "{C:green}#1# in #2#{} chance to grab",
                    "a random card when",
                    "opening a booster pack",
                    "{C:inactive}(Must have room){}",
                },
            },
            -- Substitution
            j_exotic_substitution = {
                name = "Substitution",
                text = {
                    "{C:red}Discarding{} {C:attention}1{} card draws",
                    "your most common rank",
                    "in your {C:attention}Full Deck{}"
                },
            },
            -- Tree Plum
            j_exotic_tree_plum = {
                name = "Tree Plum",
                text = {
                    "Fill your consumables slots",
                    "with {C:tarot}Tarot{} card when selecting",
                    "a {C:attention}Blind{} for the",
                    "next {C:attention}4{} rounds",
                    "{C:inactive}(Must have room){}",
                },
            },
            -- Ash Urn
            j_exotic_ash_urn = {
                name = "Ash Urn",
                text = {
                    "Gain {C:blue}Chips{} equeal to the",
                    "rank of {C:red}destroyed{} Cards",
                    "{C:inactive}(Currently {C:blue}+0{} {C:inactive}Chips)"
                },
            },
            -- Anomalous Lecture
            j_exotic_anomalous_lecture = {
                name = "Anomalous Lecture",
                text = {
                    "When selecting a {C:attention}Blind{},",
                    "{C:red}destroy{} a {C:planet}Planet{} card",
                    "and gain his {C:blue}Chips{} or {C:red}Mult{}",
                    "{C:inactive}(Currently {C:blue}+0{} {C:inactive}Chips and {C:red}+0{} {C:inactive}Mult)"
                },
            },
        },
        -- Other = { -- Seals -- Stickers -- Boosterpacks -- Undiscovered },
        -- vremade_Planet = { -- If you're making regular Planets the key will be "Planet" }, -- Custom Planets
        -- vremade_Spectral = { -- If you're making regular Spectrals the key will be "Spectral" }, -- Custom Spectrals
        -- Stake = {},
        -- Tag = {},
        -- vremade_Tarot = {}, -- If you're making regular Tarots the key will be "Tarot"
        --Voucher = {},
    },
    misc = {
        -- challenge_names = {},
        dictionary = {
            exotic_bust_upgrade = "Upgrade",
            exotic_top_qaulity_upgrade = "Best Product!",
            exotic_electric_upgrade = "Zap!",
            exotic_lucky_clover = "Lucky",
            exotic_customer_benefits = "Offer!",
            exotic_fished_card = "Catched!",
        },
        -- labels = {}, -- Labels for the Card types and rarities In Game
        -- poker_hand_descriptions = {},
        -- poker_hands = {},
        -- ranks = {}, -- No really using this, Playing card ranks
        -- suits_plural = {}, For suit names
        -- suits_singular = {}, For suit names
    }
}