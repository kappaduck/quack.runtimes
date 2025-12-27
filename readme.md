# Quack! Runtimes

Quack! Runtimes hosts [SDL] and its extensions ([SDL_image], [SDL_ttf], [SDL_mixer]) native binaries for use in development, CI/CD and packaging [Quack!]. It provides prebuilt binaries for Windows and Linux.

## Quack & SDL compatibility

Below is a list of Quack! versions and their compatible SDL versions:

| Quack! version | SDL version | SDL_image version | SDL_mixer version | SDL_ttf version |
| :------------: | :---------: | :---------------: | :---------------: | :-------------: |
|    `source`    |  `3.2.28`   |      `3.2.4`      |       `N/A`       |     `3.2.2`     |
|    `0.2.0`     |  `3.2.28`   |      `3.2.4`      |       `N/A`       |     `3.2.2`     |
|    `0.1.0`     |  `3.2.18`   |       `N/A`       |       `N/A`       |      `N/A`      |

> Support for SDL_mixer is planned for future releases. It needs SDL3 3.4.0 which is not yet released.
>
> The current Quack! development can update the SDL dependencies many times before the release.

## Installation

Please refer to the [Quack! documentation](https://github.com/kappaduck/quack#Development) for installation instructions.

[Quack!]: https://github.com/kappaduck/quack
[SDL]: https://www.libsdl.org/
[SDL_image]: https://www.libsdl.org/projects/SDL_image/
[SDL_ttf]: https://www.libsdl.org/projects/SDL_ttf/
[SDL_mixer]: https://www.libsdl.org/projects/SDL_mixer/
