--CLIENT

-- Rebirth of cl_ready. Instead of looking for the creation of LocalPlayer
-- we just wait one frame (a timer with delay of 0 executes next think) and
-- then say we're ready.
timer.Simple(0, function()
    RunConsoleCommand("~cl_ready")
end)
