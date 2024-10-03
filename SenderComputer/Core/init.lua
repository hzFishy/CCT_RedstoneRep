local sender = require "Sender"
Config = require "config"


term.setTextColor(colors.lightBlue);

sender.OpenConnection();
sender.ListenForRedstoneChange();