# Configure various tools and linux with dotfiles, these are mine.
---
## Rundown:
- Neovim
    - Prerequisite
    1. ripgrep -For Live grep-
    - Plugins
    1. rebelot/heirline.nvim -Statusline and bufferline-
    2. X3eRo0/dired.nvim -Basic Dired copy for neovim-
    3. anuvyklack/pretty-fold.nvim -Pretty folding!-
    4. Eandrju/cellular-automaton.nvim -Why do I have this?-
    5. wbthomason/packer.nvim
    6. kylechui/nvim-surround
    7. nvim-telescope/telescope.nvim
    8. lukas-reineke/indent-blankline.nvim
    - Mappings
    1. <leader>i, Open Dired
    2. <leader>o, Quit Dired
    3. <leader>f, CTRL + W x2
    4. <leader>k, CTRL + U
    5. <leader>j, CTRL + D
    6. <leader>g, ESC x2
    8. <leader>g, Next Buffer
    9. <leader>p, Previous Buffer
    10. <leader>aw, CellularAutomaton make_it_rain
    11. <leader>awww, CellularAutomaton game_of_life
    12. <C-k>, Delete Buffer
    13. K, Open Telescope buffer viewer
    14. <leader>pd, Open Telescope w/ Live grep
    - Options:
    1. Relative number with number
    2. Tab width 4 spaces
    3. Smart Indent
    4. No swap file
***
- Karabiner
    - Remappings
    1. Tab => Right super -Right CMD on macOS-
    1. Tab + H || J || K || L -Vim arrow navigation-
    3. Caps Lock => Control -Down with caps lock-
    4. Left Control => Tab
