-- Load Jokers
local jokers_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "content/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("content/jokers/" .. file))()
end
-- Load Decks
local jokers_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "content/decks")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("content/decks/" .. file))()
end
SMODS.Atlas {
    key = "joker_atlas",
    path = "placeholder.png",
    px = 71,
    py = 95
}