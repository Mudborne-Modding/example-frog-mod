-- example frog mod

return {

  -- load all our new frog stuff!
  load = function(mod_id)

    -- to add a new frog we need to update quite a few different places
    -- first we'll need to add it's definition to the dictionary
    -- then we'll need to add some new text to the localisation
    -- then we'll need to add it's colors to the global color table
    -- then we'll want to add a new entry to the frog book
    -- and finally we'll need to add all the new sprites needed

    -- first we'll add a new frog to the dictionary 'game/resources/re_dictionary'
    -- there are 30 frogs in the game so technically you could start from 31
    -- but with other modders out there you might want to pick something unique to start from
    game.g.dictionary.frog777 = {
      oid = 'frog777',
      traits = { a = 7, n = 7, o = 7, u = 3, r = 3, e = 3, s = 3 },
      -- variants are based on the standard traits, or can be explicit
      -- see other frog definitions for examples
      variants = {
        b = { u = '+' }, -- more umbrage
        c = { r = '-', s = '-' } -- quiter and dryer
      },
      taste = {'salty'}, -- the type of bug this frog will eat in the feeder
      world = 'awake' -- used to show the 'base' of the frog, i.e., 'awake', 'dream' or 'any'
      -- also used for repopulation to decide which world to spawn in, 'any' pick at random
    }

    -- then we'll define all the text for this new frog
    -- worth noting that this would get overwritten if the player changes language!
    -- maybe you can work out how to set this after a language change?
    game.g.locale.frog777_name = 'Salty Hopper'
    game.g.locale.frog777_hint = 'Make a Low-Grade Croaker fit for a king, while increasing size and odour.'
    game.g.locale.frog777_lore1 = 'Tired of their lowly status, this species has tried to make itself more appealing to the ruling caste.'
    game.g.locale.frog777_lore2 = 'They are sadly still not accepted by the nobles, with their ancestry giving themselves away.'
    game.g.locale.frog777_likes = 'High society, the finer things, pretending'
    game.g.locale.frog777_key = 'sh'
    game.g.locale.frog777b_name = 'Saltier Hopper'
    game.g.locale.frog777b_var = 'A more salty variant.'
    game.g.locale.frog777c_name = 'Humble Hopper'
    game.g.locale.frog777c_var = 'A quiter and less wet variant.'

    -- at this point you could spawn the frog in
    -- turn on dev mode with '/r1bb3t' and then spawn with '/gimme frog777'
    -- however our frog is blank! we need to add sprites and colors to bring it to life
    -- first set the colors in the global color table
    game.g.colors.frog777 = tn.util.hexToRGB('#805e61')
    game.g.colors.frog777a = tn.util.hexToRGB('#805e61')
    game.g.colors.frog777b = tn.util.hexToRGB('#914a61')
    game.g.colors.frog777c = tn.util.hexToRGB('#444a61')

    -- then load in our spritesheet and define the sprites a frog needs
    -- we use our mod_id to load from the mods folder to find our spritesheet
    local spritesheet = tn.class.texture:new('my_spritesheet', 'mods/' .. mod_id .. '/spritesheet.png')

    -- then we need to define the sprites from the spritesheet
    -- you can view the spritesheet with the .asesprite files from 'game/resources/sprites'
    -- each row is a new sprite, values are:
    -- name of sprite, x pos, y pos, width, height, no. of frames
    spritesheet:load({
      -- the 3 frog items for all 3 variants
      { "sp_frog777a_item", 0, 0, 16, 16, 2},
      { "sp_frog777b_item", 32, 0, 16, 16, 2},
      { "sp_frog777c_item", 64, 0, 16, 16, 2},
      -- the overworld frog sprite that jumps about!
      { "sp_frog777a", 0, 16, 11, 11, 3},
      { "sp_frog777b", 48, 16, 11, 11, 3},
      { "sp_frog777c", 96, 16, 11, 11, 3},
      -- the book art for the new frog (these are in the 'textures' spritesheet)
      { "sp_book_frog777a", 0, 32, 144, 64, 1}
    })

    -- now if you spawn your frog you'll see it! and you can use it as a pet
    -- or place it down, or breed it as normal
    -- for the final step you'll probably want to add a new entry to the frog book!
    -- this is done in 'game/events/ev_load' at the start of the game
    local new_chapter = {
      title = game.g.locale['frog777_name'],
      title_key = 'frog777_name',
      icon = 'frog777a'
    }
    -- first 'category' for book2 is the frog category
    table.insert(game.g.books.book2[1].chapters, new_chapter)

    -- however just adding the definition isn't enough as the books have already been defined
    -- so we need to update the actual book instance too
    local book2 = game.g.player.book2
    local category = book2.props.categories[1]
    -- while your frog 'id' could be any number, the 'index' should be sequential from current no. of frogs
    -- you could work this out based on the current count
    local index = 31
    local chapter = game.class.ui_chapter:new(0, 0, book2, 'frog777a', category, 777, 'frogs', index, index, false)
    chapter.props.key = index
    table.insert(category.props.chapters, chapter)

    -- and now you have a book entry and a shiny new frog!

    -- if you plan on adding lots of books, you might have to mess with the global 'autoscroll'
    -- values, which determine where the book scrolls to on a category select
    -- this is because if you add lots of frogs, clicking the mushroom category 
    -- will make it go off the screen

    -- be sure to check existing frog genetic keys so you don't override them!

    -- some other things to try playing with:

    -- spawn some of your frogs into the world by default, or at specific locations

    -- can you make your own new category in the encyclopedia? with it's own chapters?
    -- (you'd need to customise the book drawing functionality to render new pages!)

    return true
  end

}
