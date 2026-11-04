<div align="center">

# 🧟 Onga Bonga

**A top-down 2D survival game built with Godot and GDScript**

[![Engine](https://img.shields.io/badge/Engine-Godot%204.7-478CBF?style=flat-square&logo=godot-engine)](https://godotengine.org/)
[![Language](https://img.shields.io/badge/Language-GDScript-355570?style=flat-square&logo=godot-engine)](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
[![Genre](https://img.shields.io/badge/Genre-2D%20Survival-FF4081?style=flat-square)](#)

---

</div>

## 📖 Overview

**Onga Bonga** is a work-in-progress top-down survival game. Move through a pixel-art world, fight incoming enemies, collect experience, and strengthen your character as the day-and-night cycle changes.

## ✨ Current Features

- **🕹️ Top-down movement:** Move freely in four directions.
- **👾 Enemy waves:** Enemies spawn and pursue the player.
- **⚔️ Combat:** Attack with the hoe and throw a limited-use scythe.
- **⭐ Progression:** Collect experience orbs and choose upgrades to health, movement speed, or attack damage.
- **🌗 Day-and-night cycle:** The world transitions between day and night, with enemy waves tied to the cycle.
- **❤️ Survival systems:** Player health, healing items, and a game-over/retry flow.
- **🌐 Multiplayer groundwork:** Networking and a WebSocket tracker integration are present; multiplayer is currently disabled in the main menu.

> This project is actively being developed; features and controls may change.

## 🛠️ Tech Stack

| Layer / Tool    | Technology                           |
| :-------------- | :----------------------------------- |
| **Game Engine** | Godot 4.7                            |
| **Language**    | GDScript                             |
| **Game Type**   | 2D top-down survival                 |
| **Rendering**   | Godot 2D renderer                    |
| **Networking**  | Godot multiplayer and WebRTC add-ons |

## 📂 Project Structure

```text
.
├── BG/                  # Background art
├── Components/          # Shared gameplay systems, UI, and scenes
├── Enemy/               # Enemy scenes and spawn points
├── Items/               # Item scenes, scripts, and UI
├── Player/              # Player scene, controller, and design assets
├── Projectile/          # Projectile scenes, scripts, and UI
├── World/               # Single-player and multiplayer world scenes and scripts
├── addons/              # Godot editor and networking add-ons
├── webrtc/              # WebRTC native extension and licenses
├── project.godot        # Godot project settings and input actions
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- [Godot 4.7](https://godotengine.org/download/)
- Git

### Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/DevHatemAlDouh/Onga_bonga.git
   cd Onga_bonga
   ```

2. **Import the project:** Open Godot, choose **Import**, and select this repository's `project.godot` file.

3. **Run the game:** Press **F5** to launch the configured main scene.

### Optional: Run a local WebSocket tracker

The tracker is only needed when testing the networking functionality. Start one locally with:

```bash
npx bittorrent-tracker --ws --port 8000
```

## 🎮 Controls

| Action            | Default Input                       |
| :---------------- | :---------------------------------- |
| **Move**          | `W` / `A` / `S` / `D` or arrow keys |
| **Attack**        | Left mouse button                   |
| **Use scythe**    | Right mouse button                  |
| **Open settings** | `Escape`                            |

Controls can be reviewed or changed under **Project → Project Settings → Input Map**.

## 🤝 Contributing

Contributions, feedback, and bug reports are welcome. For changes, please open an issue or pull request describing what you changed and how you tested it.

## 👨‍💻 Developer

**Hatem Al-Douh**

- **GitHub:** [@DevHatemAlDouh](https://github.com/DevHatemAlDouh)
- **Repository:** [DevHatemAlDouh/Onga_bonga](https://github.com/DevHatemAlDouh/Onga_bonga)

<!-- {use profolio game} -->
