SMODS.Joker {
    key = "customer_benefits", atlas = "joker_atlas", pos = { x = 1, y = 0 }, -- Uncommon

    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2, cost = 6, discovered = true, unlocked = true,

    config = { 
        extra = { 
            money_spent = 0,
            required_spent = 15,
            free_reroll_active = false
        } 
    },
    
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.required_spent,
                card.ability.extra.money_spent,
                card.ability.extra.required_spent - card.ability.extra.money_spent
            } 
        }
    end,

    calculate = function(self, card, context)
        -- Detectar cuando se gasta dinero (compras en tienda)
        if context.buying_card or context.reroll_shop then
            local cost = 0
            
            -- Si es una compra de carta
            if context.buying_card and context.card then
                cost = context.card.cost or 0
            end
            
            -- Si es un reroll de tienda (y no es gratis)
            if context.reroll_shop and not card.ability.extra.free_reroll_active then
                cost = G.GAME.current_round.reroll_cost or 0
            end
            
            -- Acumular dinero gastado
            if cost > 0 then
                card.ability.extra.money_spent = card.ability.extra.money_spent + cost
                
                -- Verificar si alcanzó el umbral
                if card.ability.extra.money_spent >= card.ability.extra.required_spent then
                    card.ability.extra.money_spent = card.ability.extra.money_spent - card.ability.extra.required_spent
                    card.ability.extra.free_reroll_active = true
                    
                    -- Dar el reroll gratis
                    SMODS.change_free_rerolls(1)
                    
                    return {
                        message = localize('exotic_customer_benefits'),
                        colour = G.C.MONEY,
                        card = card
                    }
                end
            end
        end
        
        -- Detectar cuando se usa el reroll gratis
        if context.reroll_shop and card.ability.extra.free_reroll_active then
            -- Restaurar el estado después de usar el reroll gratis
            card.ability.extra.free_reroll_active = false
            SMODS.change_free_rerolls(-1)
        end
    end,

    -- Limpiar al salir de la tienda si quedó un reroll gratis sin usar
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.money_spent = 0
        card.ability.extra.free_reroll_active = false
    end,

    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.free_reroll_active then
            SMODS.change_free_rerolls(-1)
            card.ability.extra.free_reroll_active = false
        end
    end
}