local M ={}
M.maxLevels = 100
M.settings = {}
M.settings.currentLevel = 1
M.settings.unlockedLevels = 2
M.settings.soundOn = false
M.settings.musicOn = false
M.settings.levels = {}
M.settings.levels[1] = {}
M.settings.levels[1].starts = 3
M.settings.levels[1].score = 100
M.settings.levels[2] = {}
M.settings.levels[2].starts = 1
M.settings.levels[2].score = 100
return M