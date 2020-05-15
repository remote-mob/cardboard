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

1. `git clone git@github.com:objarni/cardboard.git`
2. `cd cardboard`
3. `npm install`
4. `npm run build`
5. open `cardboard/index.html` in a browser (it was created by build step)


# How to test that you can make changes and push

1. Make a funny sounding branch :)
2. Make a change in `src/Main.elm` in your editor
3. `npm run run` and browse to `localhost:8000/src/Main.elm`
4. Verify the change is visible
5. Commit and push the branch
