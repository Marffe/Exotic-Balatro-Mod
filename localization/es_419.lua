return {
    descriptions = {
        Back = {
            -- 1 Strategist Deck
            b_exotic_strategist = {
                name = "Baraja de Estratega",
                text = {
                    "{C:attention}+#1#{} al tamaño de mano",
                    "fuera de las ciegas.",
                    "Puedes seleccionar {C:attention}1{}",
                    "carta adicional de los",
                    "{C:attention}Paquetes Potenciadores{}",
                },
            },
            -- 2 Hallucinations Deck
            b_exotic_hallucination = {
                name = "Baraja Alucinógena",
                text = {
                    "Crea un consumible",
                    "al azar al abrir un",
                    "{C:attention}Paquete Potenciador{}",
                    "",
                    "Los {C:attention}Paquetes Potenciadores{}",
                    "están mezclados"
                },
            },
            -- 3 Deck of Fortune
            b_exotic_deck_o_fortune = {
                name = "Baraja de la Fortuna",
                text = {
                    "Las Cartas {C:attention}anotadas{} tienen",
                    "una prob. de {C:green}#1# en 8{} de obtener",
                    "edición {C:dark_edition}Laminada{}, {C:dark_edition}Holográfica{}",
                    "o {C:dark_edition}Policroma{}",
                    "",
                    "Los consumibles pueden",
                    "activarse sin {C:red,E:2}efectos{}",
                },
            },
            -- 4 Baraja de Espinas
            b_exotic_spiked_deck = {
                name = "Baraja de Espinas",
                text = {
                    "Obtienes 2 Copias del {C:tarot}Colgado",
                    "al derrotar la {C:attention}Ciega Jefe{}"
                },
            },
            -- 5 Baraja del Obelisco
            b_exotic_obelisk_deck = {
                name = "Baraja del Obelisco",
                text = {
                    "Ganas {X:red,C:white}X0.1{} Multi por mano",
                    "no consecutiva jugada.",
                    "Pierdes la mitad de tu {X:red,C:white}XMulti{}",
                    "al jugar una mano",
                    "de forma consecutiva",
                    "{C:red}X1.5{} al tamaño de Ciega"
                },
            },
        },
        -- Blind = {},
        -- Edition = {},
        -- Enhanced = {},
        Joker = {
            -- Rope
            j_exotic_rope = {
                name = "Soga",
                text = {
                    "Gana {C:blue}+#1#{} Fichas antes",
                    "de enfrentar la {C:attention}Ciega Jefe{}",
                    "{C:inactive,s:0.7}(Excelente para amarrar cosas)",
                    "{C:inactive}(Actualmente {C:chips}+#2#{} {C:inactive}Fichas)"
                },
            },
            -- Perfected Gem
            j_exotic_perfected_gem = {
                name = "Gema Perfeccionada",
                text = {
                    "Los {C:diamonds}Diamantes{} otorgan {X:red,C:white}X#4#{} Multi",
                    "al anotar y aumenta {X:red,C:white}X#2#{} por",
                    "cada {C:money}$#3#{} que tengas",
                },
            },
            -- Bust
            j_exotic_bust = {
                name = "Busto",
                text = {
                    "Las {C:attention}Cartas de Piedra{}",
                    "ganan {C:mult}+3{} Multi al anotar"
                },
            },
            -- Top Quality
            j_exotic_top_quality = {
                name = "Calidad Premium",
                text = {
                    "Gana {C:mult}+#1#{} Multi si tu mano",
                    "jugada es exactamente",
                    "un {C:attention}10{} y otro {C:attention}10{}",
                    "{C:inactive}(Actualmente {C:mult}+#2#{} {C:inactive}Multi)"
                },
            },
            -- Power Spike
            j_exotic_power_spike = {
                name = "Pico de Corriente",
                text = {
                    "Gana {X:red,C:white}X#1#{} Multi por",
                    "cada {C:attention}Carta Multi{} en tu",
                    "mano jugada",
                    "{C:inactive}(Actualmente {X:red,C:white}X#2#{} {C:inactive}Multi)"
                },
            },
            -- Cooler Joker
            j_exotic_cooler_joker = {
                name = "Comodín Pro",
                text = {
                    "{C:red}+#2#{} Multi,",
                    "gana {C:red}+#1#{} si la",
                    "{C:attention}puntuación{} se",
                    "prende en {C:red,E:1}llamas{}",
                    "{C:inactive}(Actualmente {C:red}+#2#{} {C:inactive}Multi)"
                },
            },
            -- Suportive Joker
            j_exotic_supportive_joker = {
                name = "Comodín de Compañía",
                text = {
                    "Gana {C:blue}+#1#{} Fichas por cada",
                    "carta sin {C:attention}anotar{} en",
                    "tu mano jugada",
                    "{C:inactive}(Actualmente {C:blue}+#2#{} {C:inactive}Fichas)"
                },
            },
            -- Lucky Clover
            j_exotic_lucky_clover = {
                name = "Trébol de la Suerte",
                text = {
                    "Jugar un {C:attention}Color{} de {C:clubs}Tréboles{}",
                    "tiene una prob. de {C:green}#1# en #2#{}",
                    "de crear a {C:tarot}El Mago{}",
                },
            },
            -- Upper Management
            j_exotic_upper_management = {
                name = "Dirección Ejecutiva",
                text = {
                    "{C:blue}+#1#{} Fichas y {C:red}+#2#{} Multi, las",
                    "cartas anotadas se {C:red}debilitan{}",
                    "hasta que ganes la {C:attention}Apuesta{}",
                    "{C:inactive,s:0.8}(Se remueve la debilitación al venderse{}",
                },
            },
            -- Customer Benefits
            j_exotic_customer_benefits = {
                name = "Beneficios de Consumidor",
                text = {
                    "Ganas una {C:green}Renovación{}",
                    "de la tienda cada",
                    "{C:money}#1#${} {C:inactive}(#2#/15){} gastados"
                },
            },
            -- Substitution
            j_exotic_substitution = {
                name = "Relevo",
                text = {
                    "Al {C:red}descartar{} {C:attention}1{} carta sacas",
                    "una carta de la {C:attention}categoría más",
                    "{C:attention}común{} en tu {C:attention}Baraja{}"
                },
            },
            -- Fishing rod
            j_exotic_fishing_rod = {
                name = "Caña de pescar",
                text = {
                    "Prob. de {C:green}#1# en #2#{} de",
                    "tomar una carta de los",
                    "{C:attention}Paquetes Potenciadores{}"
                },
            },
            -- Tree Plum
            j_exotic_tree_plum = {
                name = "Ciruela de Árbol",
                text = {
                    "Al seleccionar una {C:attention}Ciega{}, llena tus",
                    "consumibles con cartas del {C:tarot}Tarot{}",
                    "#3# la#2# siguiente#2# ronda#2#",
                    "{C:inactive}(Rondas restantes: {C:attention}#1#{}{C:inactive})",
                    "{C:inactive}(Debe haber espacio){}",
                },
            },
            -- Ash Urn
            j_exotic_ash_urn = {
                name = "Urna de Cenizas",
                text = {
                    "Gana las {C:blue}Fichas{} de las",
                    "cartas {C:red}destruidas{}",
                    "{C:inactive}(Actualmente {C:blue}+#1#{} {C:inactive}Fichas)"
                },
            },
            -- Anomalous Lecture
            j_exotic_anomalous_lecture = {
                name = "Lectura Ánomala",
                text = {
                    "Al seleccionar una {C:attention}Ciega{},",
                    "{C:red}destruye{} una carta de {C:planet}Planeta{}",
                    "y gana {X:attention,C:white}X2{} sus {C:blue}Fichas{} o {C:red}Multi{}",
                    "{C:inactive}(Actualmente {C:blue}+#1#{} {C:inactive}Fichas y {C:red}+#2#{} {C:inactive}Multi)"
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
            exotic_bust_upgrade = "Mejora",
            exotic_top_qaulity_upgrade = "10/10",
            exotic_electric_upgrade = "¡Zap!",
            exotic_lucky_clover = "¡Suertudo!",
            exotic_customer_benefits = "¡Oferta!",
        },
        -- labels = {}, -- Labels for the Card types and rarities In Game
        -- poker_hand_descriptions = {},
        -- poker_hands = {},
        -- ranks = {}, -- No really using this, Playing card ranks
        -- suits_plural = {}, For suit names
        -- suits_singular = {}, For suit names
    }
}