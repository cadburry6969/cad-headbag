Config = {}

Config.UseHeadbagTimeout = 3000 -- (milliseconds)

-- what animation is required from target to put headbag on them
Config.HandsupAnimations = {
    {
        dict = 'missminuteman_1ig_2',
        anim = 'handsup_base'
    },
    {
        dict = 'anim@mp_player_intuppersurrender',
        anim = 'idle_a_fp'
    },
    {
        dict = 'anim@mp_rollarcoaster',
        anim = 'hands_up_idle_a_player_one'
    }
}

-- object to attach the player when headbag worn
Config.ObjectAttach = {
    model = `prop_money_bag_01`,
    bone = 12844,
    xPos = 0.2,
    yPos = 0.04,
    zPos = 0,
    xRot = 0,
    yRot = 270.0,
    zRot = 60.0
}

-- edit the item info in `config/config_server.lua`
-- set this to true if you dont want headbag as item
Config.DisableItem = false

-- command to toggle headbag
Config.ToggleCommand = 'headbag' -- false: disable command
Config.ToggleCommandHelp = 'Put/remove headbag'

-- command to remove headbag
Config.RemoveCommand = 'removeheadbag' -- false: disable command
Config.RemoveCommandHelp = 'Remove Headbag'
Config.RemoveCommandKey = 'R' -- key to remove headbag

-- notification language
Config.Lang = {
    ['no_one_nearby'] = 'No one nearby',
    ['use_timeout'] = 'Please wait before you try again',
    ['no_handup'] = 'Person\'s hands are down',
    ['no_headbag_onhead'] = 'Person doesnt have headbag on their head',
}
