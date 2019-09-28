# mosh-massacre
TL;DR : Kills disconnected mosh sessions

When the terminal gets closed with an active mosh session, while it's disconnected with the server (no internet), after relogging to the server presents a message.
> Mosh: You have a detached Mosh session on this server (mosh [12345]).
You can't really [connect back](https://github.com/mobile-shell/mosh/issues/394) to that mosh session if the terminal window is lost due to security reasons.
The only available action is to kill those sessions on server. When the sessions are not closed, they pile up over time and the message becomes annoying.

Here's the script to kill those sessions

1. Copy the script to `path` location on server.
```
scp mosh-massacre.sh username@10.0.0.1:/tmp
sudo cp /tmp/mosh-massacre /usr/local/bin/mosh-massacre
```

Usage:

> `mosh-massacre` : Kills all disconnected mosh sessions for your user `Hint: whoami`

> `mosh-massacre -u username` : Kills all disconnected mosh sessions for the specified user

> `mosh-massacre -a` : Kills all disconnected mosh sessions for all the users

> `mosh-massacre -h` : Displays this help



mosh-massacre: massacre because it kills a bunch of mosh sessions plus nice alliteration ;)
