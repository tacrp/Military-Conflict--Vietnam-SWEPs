"""Targeted, atomic patch for the weapon initialization path."""
from pathlib import Path
import os

path = Path(__file__).resolve().parents[1] / 'lua/mcv/weapon_common/sh_deploy.lua'
text = path.read_text()
marker = '    // GMod merges nested lists:'
if marker not in text:
    insertion = '''    // GMod merges nested lists: a derived one-mode gun can inherit a duplicate
    // second entry. Keep a private, dense list of distinct numeric modes.
    if self.Firemodes then
        local modes, seen = {}, {}
        local selected = self.Firemodes[self:GetFiremode()]
        for _, mode in ipairs(self.Firemodes) do
            if isnumber(mode) and !seen[mode] then
                modes[#modes + 1] = mode
                seen[mode] = #modes
            end
        end
        self.Firemodes = modes
        self:SetFiremode(seen[selected] or 1)
    end
'''
    assert text.count('function SWEP:Initialize()\n') == 1
    text = text.replace('function SWEP:Initialize()\n', 'function SWEP:Initialize()\n' + insertion)
    temporary = path.with_suffix('.lua.tmp')
    temporary.write_text(text)
    os.replace(temporary, path)
print('Firemode initialization normalization installed.')
