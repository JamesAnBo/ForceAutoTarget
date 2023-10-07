addon.name    = 'forceautotarget'
addon.author  = 'Aesk'
addon.version = '1.0'
addon.desc    = 'Forces auto target to OFF on zone'

require('common');

local chat = require('chat');
local Toggles = true;

local function ForceAutoTarget()
	if Toggles == false then
		AshitaCore:GetChatManager():QueueCommand(1, '/autotarget off ')
	else
		return
	end
end

ashita.events.register('packet_in', 'packet_in_cb', function(e)
    if e.id == 0x000A then
		ForceAutoTarget:once(3);
    end
end)

ashita.events.register('load', 'load_cb', function()

end)

ashita.events.register('command','command_cb', function (e)
    -- Parse the command arguments..
    local args = e.command:args();
    if (#args == 0 or (args[1] ~= '/forceautotarget' and args[1] ~= '/fat')) then
		return
	else
		if Toggles == false then
			Toggles = true;
			AshitaCore:GetChatManager():QueueCommand(1, '/autotarget on')
			print(chat.header(addon.name):append(chat.message('Auto-target will reset to ON')));

		else
			Toggles = false;
			AshitaCore:GetChatManager():QueueCommand(1, '/autotarget off')
			print(chat.header(addon.name):append(chat.message('Auto-target will turn OFF on zone')));
		end
    end

    e.blocked = true;

end);