# Mindasaurus Ex

Mindasaurus is an application that allows a person to create reminders
easily. These reminders should be brief, but they should also be retrievable
and taggable.

## Rationale

I find myself often wanting to remind myself about something --
a restaurant I want to remember to go back to, a blog post
idea I don't want to forget, a cocktail recipe I see on a menu. I sometimes
send myself an email or text myself or drop it in a Slack message to myself.
Or, sometimes, I just forget it. This application is to provide me a central
place for these quick reminders, and this project aims to give easy access to
just such a central place.

This is also a project idea I use to play with new programming languages -- much
like you see examples using todo list applications as example programs. In the
case of this incarnation, I'm playing with Elixir.

## Status

Currently a user can create an account and then save reminders using an
API access key. They can also retrieve reminders by account API key.

This is an Elixir application that uses the umbrella app concept. The API
UI is a Phoenix app that uses the underlying applications for domain logic
and database access.


