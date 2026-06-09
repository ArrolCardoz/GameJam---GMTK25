# Hungry Animals!! (GMTK Game Jam 2025)

A fast-paced, loop-based kitchen management simulation built for the GMTK 2025 Game Jam.

## 🎮 Play the Game

You can play the current build here: **[Hungry Animals!! - itch.io](https://airall.itch.io/hungry-animals)**

![Player Movement Animation](assets/player/walkingTutorial.gif)

## 🎮 The Concept

In **Hungry Animals!!**, the player takes on the role of a chef trapped in an endless loop, forced to serve the same hungry customers every single day. The gameplay focuses on managing multiple kitchen stations, balancing cooking times, and fulfilling orders under pressure.

_Note: I am currently refactoring the core kitchen-logic systems to resolve stability issues found during the jam. Stay tuned for the v2.0 engine update!_

## 🛠️ Technical Stack

- **Engine:** [Godot Engine](https://godotengine.org/)
- **Language:** GDScript
- **Assets:**
  - _Sunny Land_ (Unity Asset Store)
  - _Roguelike Indoors_ (Kenney Assets)

## 🏗️ Development Context & "Lessons Learned"

This project was developed over a 58-hour crunch period during the 4-day GMTK 2025 Game Jam. As this was my second month of active game development, the project served as an intense crash course in real-time engine mechanics and state management.

### Identified Technical Debt (The "Jam Code")

While the prototype successfully captured the "loop" theme and core kitchen loop, the rapid development cycle introduced significant architectural bottlenecks:

- **Reference Management:** The oven implementation lacked a unique reference/ID system, causing state corruption when multiple ovens were used simultaneously.
- **Component Coupling:** High tight-coupling between timers and item entities led to the "missing item" bug when object state was cleared unexpectedly.
- **Scheduling System:** Due to the time constraints, the intended primary scheduling mechanic was not fully implemented.

## 🚀 The Path Forward: Version 2.0

Rather than patching the "Jam Code," I have decided to refactor the entire project from the ground up. This rewrite is currently in progress, focusing on:

1. **Decoupled Architecture:** Implementing an Observer pattern/Signal system in Godot to ensure stations and items communicate without direct reference dependency.
2. **Object Pooling:** Optimizing memory management for items to prevent state deletion bugs.
3. **Robust Scheduling:** Properly implementing the intended kitchen scheduling logic to provide the depth originally envisioned for the GMTK theme.

---

_Project developed by Arrol Cardoz for the GMTK Game Jam 2025._
