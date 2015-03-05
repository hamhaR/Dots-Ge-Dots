local M ={}
M.maxLevels = 5
M.settings = {}
M.settings.easy = 9
M.settings.currentLevel = 1
M.settings.unlockedLevels = 5
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