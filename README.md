# cardboard

Explanatory video: https://www.youtube.com/watch?v=SuXTF_rZZRA


# Instructions for dev environment

1. Pick an editor and install Elm plugin(s):

  * Atom
  * IntelliJ
  * Sublime Text
  * VS Code

2. Make sure npm is available:

   npm --version

.. which should print something like 6.14 (or newer)
   

# How to test that dev environment works

1. `git clone git@github.com:remote-mob/cardboard.git`
2. `cd cardboard`
3. `npm install`
4. `npm run build`
5. open `cardboard/index.html` in a browser (it was created by build step)

## Elm-live

Elm-live is nice to use to avoid having to click refresh when debugging with
a browser. To install it you need `node >= 10.0.0`. If you have installed 
node with a package manager this might not be the case and you will get this
warning:

    $ npm install elm-live
    WARN engine elm-live@4.0.2: wanted: {"node":">= 10.0.0"} (current: {"node":"8.10.0","npm":"3.5.2"})
    ...

Here are instructions how to get a newer version (using Node Version Manager to
manage Node versions):

    sudo apt remove npm
    sudo apt autoremove  # Cleans up packages not needed after npm removal
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    source ~/.bashrc  # or restart shell
    nvm install --lts
    npm run elm-live  # Open http://localhost:8000 and check that it works


# How to test that you can make changes and push

1. Make a funny sounding branch :)
2. Make a change in `src/Main.elm` in your editor
3. `npm run run` and browse to `localhost:8000/src/Main.elm`
4. Verify the change is visible
5. Commit and push the branch
