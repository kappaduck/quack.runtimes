# Quack! Runtimes

Quack! Runtimes hosts [SDL] and its extensions ([SDL_image], [SDL_ttf], [SDL_mixer]) native binaries for use in development, CI/CD and packaging [Quack!]. It provides prebuilt binaries for Windows and Linux.

## Quack & SDL compatibility

Quack! is shipped with native binaries of SDL and its extensions.
Below is a compatibility table showing which versions of SDL are used in each Quack! release.

| Quack! version | SDL version | SDL_image version | SDL_ttf version | SDL_mixer version |
| :------------: | :---------: | :---------------: | :-------------: | :---------------: |
|    `source`    |   `3.4.0`   |      `3.2.6`      |     `3.2.2`     |       `N/A`       |
|    `0.4.0`     |   `3.4.0`   |      `3.2.6`      |     `3.2.2`     |       `N/A`       |
|    `0.3.0`     |  `3.2.30`   |      `3.2.6`      |     `3.2.2`     |       `N/A`       |
|    `0.2.0`     |  `3.2.28`   |      `3.2.4`      |     `3.2.2`     |       `N/A`       |
|    `0.1.0`     |  `3.2.18`   |       `N/A`       |      `N/A`      |       `N/A`       |

> :warning: During active development, SDL dependencies may be updated frequently. :warning:

## Installation

Please refer to the [Quack! documentation](https://github.com/kappaduck/quack#Development) for installation instructions.

[Quack!]: https://github.com/kappaduck/quack
[SDL]: https://www.libsdl.org/
[SDL_image]: https://www.libsdl.org/projects/SDL_image/
[SDL_ttf]: https://www.libsdl.org/projects/SDL_ttf/
[SDL_mixer]: https://www.libsdl.org/projects/SDL_mixer/
