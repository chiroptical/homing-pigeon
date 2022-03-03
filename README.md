# homing-pigeon

Quantum Theory applied to Chemistry

Read literature and write code for Quantum Theory applied in Chemistry

[![Chiroptical](https://img.shields.io/badge/twitch.tv-chiroptical-purple?logo=twitch&style=for-the-badge)](https://twitch.tv/chiroptical)

## Goals

1. Complete [Quantum Theory for Chemical Applications (QTCA) by Jochen Autschbach][qtca]
2. Complete [Molecular Electronic Structure Theory (MEST) by Trygve Helgaker][mest]

## Plan

- [QTCA][qtca]
  - [ ] Linear Algebra Essentials (Appendix B)
  - [ ] Complete Part I 

## Libraries

- [Hasktorch][ht] functional differentiable programming, tensors, and linear algebra in Haskell

## Build

The only supported build path is through nix flakes

### Using nix shell

```
> nix develop .
nix> make build
```

### Using nix build

```
> nix build .#
```

## Why homing-pigeon?

Professor Autschbach gave me [Schrodinger's Cat Trilogy][sct] for completing my PhD studies.
The final book is called "The Homing Pigeons".

[qtca]: https://www.amazon.com/Quantum-Theory-Chemical-Applications-Concepts/dp/0190920807
[mest]: https://www.amazon.com/Molecular-Electronic-Structure-Theory-Trygve-Helgaker/dp/1118531477
[ht]: https://github.com/hasktorch/hasktorch
[sct]: https://www.amazon.com/Schrodingers-Trilogy-Robert-Anton-Wilson/dp/0440500702
