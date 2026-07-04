# space-shooty

A small 2D pixel-art space shooter built with the [Godot Engine](https://godotengine.org/) (4.7).

## Gameplay

Fly your ship, dodge, and shoot down strafing enemies against a scrolling starfield.

## Controls

| Action | Key |
| ------ | --- |
| Move   | Arrow keys |
| Shoot  | Space |

## Running

1. Open the Godot editor (4.7) and import this folder as a project.
2. Press **Play** — the main scene is `scenes/game.tscn`.

The game runs at a 384×216 pixel viewport, scaled up on launch.

## Project layout

```
scenes/    Godot scenes (game, player, enemy, bullet)
scripts/   GDScript for player, enemy, and bullet behavior
assets/    Spritesheet and parallax starfield backgrounds
```
