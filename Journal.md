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
- Move cards relative to initial position (avoid snapping card to upper left corner)
 