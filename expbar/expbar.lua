local math = require('math')
local player = require('player')
local client_data = require('client_data')
local string = require('string')
local ui = require('ui')
local windower = require('windower')

local window_state = {
    title = 'Exp Bar',
    style = 'chromeless',
    x = math.floor(windower.settings.ui_size.width / 2) - 350,
    y = 1,
    width = 750,
    height = 16,
    color = ui.color.rgb(0, 0, 0, 0),
}

ui.display(function()
    window_state = ui.window('expbar_window', window_state, function()
        local do_merits = (player.merit_unknown_1 or player.merit_unknown_2) and player.merit_unknown_3
        local color = 'khaki'
        local ui_color = ui.color.khaki
        local percent = 0
        local current = 0
        local required = 0
        
        if do_merits then
            color = 'dodgerblue'
            ui_color = ui.color.dodgerblue
            current = player.limit_points
            required = 10000
        else
            current = player.exp
            required = player.exp_required
        end
        
        percent = current / required

        ui.location(0, 0)
        if do_merits then
            ui.text(string.format('[%d/%d Merits]{bold color:%s stroke:"%s"}',
                player.merit_points,
                player.merit_points_max,
                color, '1px black'))
        else
            ui.text(string.format('[%s%d/%s%d]{bold color:%s stroke:"%s"}',
                client_data.jobs[player.main_job_id].abbreviation, player.main_job_level,
                client_data.jobs[player.sub_job_id].abbreviation, player.sub_job_level,
                color, '1px black'))
        end

        ui.location(100, 5)
        ui.size(500, 2)
        ui.progress(percent, {color = ui_color})

        ui.location(605, 0)
        ui.text(string.format('[%s/%s(%s%%)]{bold color:%s stroke:"%s"}',
            current, required,
            math.floor(percent*100),
            color, '1px black'))
    end)
end)

--[[
Copyright © 2019, John S Hobart
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Windower Dev Team nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE WINDOWER DEV TEAM BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]
