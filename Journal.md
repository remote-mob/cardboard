## 2020-06-07 19:30

- Animating lifting/releasing cards, using css transitions
- The grabbed card lies above others

**Insights**
- Hard for the navigator, and the rest of the mob, to verify audio and
  visual queues.
- Google hangout is less cpu intensive than meet.jit.si and might be a better
  tool for mobbing.
- Using CSS for simple animation is easy.

## 2020-06-01 07:00

- The shadow is red and looks unrealistic
- When grabbing a card, it does not look as if it is 'lifted' because 
  it stays at the exact same location as when it was on table. Offset
  slightly?
- Be able to move any visible card.

**Insights**

- Event-based switches work when changes are small and there is a risk
  that some rotations take very long.
- Happy and surprised that we managed to complete so many TODOs.
- Depending on the task it's good to get some help finding where in the
  code changes should be made. The risk is that the way solutions are made are limited.

## 2020-05-26 19:00

- Merge mob-session into master and continue development on master.
- Made model custom type where only one of the cases can have a card in hand.
- Inverted case expression in update and changed in to a tuple on both model and message.

**Insights**

- Thumbs up for event-based rotation of the mob roles.
- Leading mob-session with discussion was good:
  - It put people in the same mindset, with the same goal
  - Acts as a outlet for opinions so that we can leave them behind us, even when not all of us agree.
- The team could consider using the first 30 ish min to groom the TODO.

## 2020-05-25 07:00

- View with hard-coded cards.
- Move from literal data to types.

**Insights**

- Better approach with the list of cards, nice.
- Better routine in the mob, nice
- A little short with 6 minutes time slots. Some kind om flexible timer could be better.

## 2020-05-22 12:00

- Started implementation of multiple card feature
- Refactored card to its own proper type (and file)
- Implement cards that are currently being moved are styled differently with shadow

**Insights**

- We experimented with doing a "probe" of 6 minutes,
  where the only purpose was investigating a certain change
  of the code, to learn if it was a viable path. We threw
  away most of the changes afterwards.
- We had 10 minutes connection talking at start of meeting,
  just checking how everyones day was.
- We discussed https://mikadomethod.wordpress.com/ (Mikado method) to find what pain points a certain change would have,
  and then doing the actual refactoring in the reverse order

## 2020-05-22 7:00

_Problem_ The upper left corner of the card snaps to the current position of the mouse when moving card

_Goal_ Move card relative to its initial position

_Solution_ Keep track of the offset position of the mouse inside the card on mouse down event. We save the offset in the cardState field and use it when receiving mouse move messages to calculate new position of the card. The InHand variant of the cardState type has been extended to keep the offset

## 2020-05-20 13:00

- Implement card doesn't move unless you click on it
- Added Hardcode more cards and render them to TODO
- We also cleaned up some of the code, mostly related to events

## 2020-05-18 13:00

- Most time was spent renaming and refactoring
- The svg is now completely gone
- The div containing hello world is colored red (with some padding)
- The hello div is now moved instead of the old svg rectangle
- The state of the application does not mention card, it is understood from the domain.

**Suggestions for next steps**

- Create more cards by extracting current modle into a Card type and Letting the model type be a list of them
- Only move card when pointer is inside div when being clicked
- Figure out which card has been clicked and only move it.

## 2020-05-15 10:00

- An Elm application consists of Model, View and Update (see https://guide.elm-lang.org/architecture/)
- Model: We added a new field to the model named helloPos with x- and y-coordinates.
- View function: We decided not to use the svg element for now. We decided to use the div element containing the text "Hejsan" instead. We set the position of the div element according to the helloPos field in the model. We changed the text to "Hello".
- Update function: We added a new variant named PointerDownMsgInt to the custom type Msg (https://guide.elm-lang.org/types/custom_types.html).

**Suggestions for next steps**

- Update function: Add PointerDownMsgInt to the case statement to update helloPos coordinates in the Model when the PointerDownMsgInt is received.
- View changes: Add a Pointer.onDown event to the main div element (line 102) to react to the user clicking anywhere on the web page. Generate a PointerDownMsgInt with the x- and y-coordinates when this happens.
