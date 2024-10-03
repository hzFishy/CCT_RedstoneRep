local listener = require "Listener"
Config = require "config"


term.setTextColor(colors.lightBlue);

listener.OpenConnection();
listener.WaitForMessages();
