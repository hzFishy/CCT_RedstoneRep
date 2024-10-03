local files = {
  "Core/Listener/init.lua",
  "Core/config.lua",
  "Core/init.lua"
}

local function ternary(condition, value_if_true, value_if_false)
  if condition then
      return value_if_true
  else
      return value_if_false
  end
end

local function splitWrite(tbltext,tblcolors,skipline)
  ternary(skipline == nil, true, skipline)
  for i, text in ipairs(tbltext) do
      local color = tblcolors[i]
      if color then
          changeColor(color)
      else
          changeColor(colors.white)
      end
      write(text)
  end
  if skipline then
      print()
  end
  resetColor()
end
local function askInput()
  resetColor()
  write("> ")
end


local url = "https://raw.githubusercontent.com/hzFishy/CCT_RedstoneRep/refs/heads/main/SenderComputer/"
local tasks = {}
for i, path in ipairs(files) do
  tasks[i] = function()
    local req, err = http.get(url.. path)
    if not req then error("Failed to download " .. url..path .. ": " .. err, 0) end

    local file = fs.open(path, "w")
    file.write(req.readAll())
    file.close()

    req.close()
    end
end

shell.run("set motd.enable false")
print("Disabled motd, do 'set motd.enable true' to set back to enable")

print("=== Starting instalation ===")
parallel.waitForAll(table.unpack(tasks))

print("Core successfully installed!")
print("Run /Core/init.lua to start.")

io.open("startup.lua", "w"):write('shell.run("/Core/init.lua")'):close()
print("Created a startup file for Core")

print("=== Instalation complete ===")
