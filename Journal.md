2020-05-22 12:00
- Started implementation of multiple card feature
- Refactored card to its own proper type (and file)
- Implement cards that are currently being moved are styled differently with shadow


Insights
--------
* We experimented with doing a "probe" of 6 minutes,
where the only purpose was investigating a certain change
of the code, to learn if it was a viable path. We threw
away most of the changes afterwards.
* We had 10 minutes connection talking at start of meeting,
just checking how everyones day was.
* We discussed https://mikadomethod.wordpress.com/ (Mikado method) to find what pain points a certain change would have,
and then doing the actual refactoring in the reverse order


2020-05-22 7:00
Problem: The upper left corner of the card snaps to the current position of the mouse when moving card.
Goal: Move card relative to its initial position.
Solution: Keep track of the offset position of the mouse inside the card on mouse down event. We save the offset in the cardState field and use it when receiving mouse move messages to calculate new position of the card. The InHand variant of the cardState type has been extended to keep the offset.


2020-05-20 13:00
- Implement card doesn't move unless you click on it
- Added Hardcode more cards and render them to TODO
- We also cleaned up some of the code, mostly related to events


2020-05-18 13:00
- Most time was spent renaming and refactoring
- The svg is now completely gone
- The div containing hello world is colored red (with some padding)
- The hello div is now moved instead of the old svg rectangle
- The state of the application does not mention card, it is understood from the domain.


Suggestions for next steps
--------------------------
- Create more cards by extracting current modle into a Card type and Letting the model type be a list of them
- Only move card when pointer is inside div when being clicked
- Figure out which card has been clicked and only move it.


2020-05-15 10:00
- An Elm application consists of Model, View and Update (see https://guide.elm-lang.org/architecture/)
Model: We added a new field to the model named helloPos with x- and y-coordinates.
- View function: We decided not to use the svg element for now. We decided to use the div element containing the text "Hejsan" instead. We set the position of the div element according to the helloPos field in the model. We changed the text to "Hello".
- Update function: We added a new variant named PointerDownMsgInt to the custom type Msg (https://guide.elm-lang.org/types/custom_types.html).


Suggestions for next steps
--------------------------
- Update function: Add PointerDownMsgInt to the case statement to update helloPos coordinates in the Model when the PointerDownMsgInt is received.
- View changes: Add a Pointer.onDown event to the main div element (line 102) to react to the user clicking anywhere on the web page. Generate a PointerDownMsgInt with the x- and y-coordinates when this happens.
