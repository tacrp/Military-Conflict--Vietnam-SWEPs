import re

# what the game's firing tiers and third person foley become in GMod (see the note below)
# Reach in units is 50 * (level - 50), so a level is 50 + units/50, and a metre is 39.37 units.
# 180 is where Source's named soundlevels stop and is also a real ceiling: a distant report set
# to 286, which the arithmetic puts at 300 m, did not play at all. 179 is as far as this goes.
LEVEL_OVERRIDES = {
    75: 109,   # the near report, about 75 m
    94: 179,   # the distant one, about 164 m, the furthest the engine will carry one
    60: 80,    # foley meant for the people around the player, about 38 m
}

# Mapping for soundlevel to numerical level
soundlevel_mapping = {
    'SNDLVL_NONE': 0,
    'SNDLVL_20dB': 20,
    'SNDLVL_25dB': 25,
    'SNDLVL_30dB': 30,
    'SNDLVL_35dB': 35,
    'SNDLVL_40dB': 40,
    'SNDLVL_45dB': 45,
    'SNDLVL_50dB': 50,
    'SNDLVL_55dB': 55,
    'SNDLVL_IDLE': 60,
    'SNDLVL_60dB': 60,
    'SNDLVL_65dB': 65,
    'SNDLVL_STATIC': 66,
    'SNDLVL_70dB': 70,
    'SNDLVL_NORM': 75,
    'SNDLVL_75dB': 75,
    'SNDLVL_80dB': 80,
    'SNDLVL_TALKING': 80,
    'SNDLVL_85dB': 85,
    'SNDLVL_90dB': 90,
    'SNDLVL_94dB': 94,
    'SNDLVL_95dB': 95,
    'SNDLVL_100dB': 100,
    'SNDLVL_105dB': 105,
    'SNDLVL_110dB': 110,
    'SNDLVL_120dB': 120,
    'SNDLVL_130dB': 130,
    'SNDLVL_GUNFIRE': 140,
    'SNDLVL_140dB': 140,
    'SNDLVL_150dB': 150,
    'SNDLVL_180dB': 180,
}

# Mapping for pitch constants to numerical values
pitch_mapping = {
    'PITCH_NORM': 100,
    'PITCH_LOW': 95,
    'PITCH_HIGH': 120,
}

import re

def parse_key_value(line):
    m = re.findall(r'"([^"]*)"', line)
    if len(m) == 2:
        return m[0], m[1]
    else:
        return None, None

def process_wave_path(wave_value, path_prefix):
    # Extract any leading non-alphanumeric characters
    prefix_match = re.match(r'^([^a-zA-Z0-9]*)(.*)', wave_value)
    if prefix_match:
        special_prefix, rest_of_path = prefix_match.groups()
    else:
        special_prefix, rest_of_path = '', wave_value

    # Newer Source branches use '~' (HRTF) and '`' which GMod's engine does not know; they
    # would end up as part of the filename. Keep only the sound chars GMod understands.
    special_prefix = ''.join(c for c in special_prefix if c in '*#@><^)(}?!$')
    
    # Clean up the path
    cleaned_path = rest_of_path.replace('\\', '/')
    
    # Combine the special prefix, path prefix, and cleaned path
    return f"{special_prefix}{path_prefix}{cleaned_path}"

def parse_soundscript(filename):
    entries = []
    with open(filename, 'r') as f:
        lines = f.readlines()

    nesting_levels = []
    current_entry = None
    wave_list = []

    for line in lines:
        # Remove comments and strip whitespace
        line = line.split('//')[0].strip()
        if not line:
            continue

        if line.startswith('"') and not nesting_levels:
            name = line.strip('"')
            current_entry = {'name': name}
            entries.append(current_entry)
            continue

        if '{' in line:
            nesting_levels.append('{')
            continue

        if '}' in line:
            if nesting_levels:
                nesting_levels.pop()
                if wave_list:
                    current_entry['sound'] = wave_list.copy()
                    wave_list = []
            else:
                current_entry = None
            continue

        if current_entry is not None:
            key, value = parse_key_value(line)
            if key:
                if key == 'wave':
                    # We'll process the path later when we know the path_prefix
                    wave_list.append(value)
                else:
                    if key in ['channel', 'volume', 'soundlevel', 'pitch']:
                        current_entry[key] = value

    return entries

def process_entries(entries, prefix, path_prefix):
    for entry in entries:
        # Process sound paths if they exist
        if 'sound' in entry:
            if isinstance(entry['sound'], list):
                entry['sound'] = [process_wave_path(wave, path_prefix) for wave in entry['sound']]
            else:
                entry['sound'] = process_wave_path(entry['sound'], path_prefix)

        # Rest of your existing processing logic remains the same
        entry['name'] = prefix + entry['name']
        
        # Process soundlevel
        soundlevel = entry.get('soundlevel', None)
        if soundlevel in soundlevel_mapping:
            entry['level'] = soundlevel_mapping[soundlevel]
        else:
            try:
                entry['level'] = int(soundlevel)
            except (ValueError, TypeError):
                entry['level'] = 75
        entry.pop('soundlevel', None)

        # GMod attenuates a soundlevel far more steeply than the game does, so the mix that
        # came out of the game's own scripts put a rifle shot out of earshot within a few
        # metres. The firing tiers and the third person foley move up to suit; everything else
        # (melee, explosions, the first person foley riding the viewmodel) keeps its number.
        entry['level'] = LEVEL_OVERRIDES.get(entry['level'], entry['level'])

        # Process volume
        volume = entry.get('volume', '1.0')
        try:
            entry['volume'] = float(volume)
        except ValueError:
            entry['volume'] = 1.0

        # Process pitch
        pitch = entry.get('pitch', None)
        if pitch:
            pitch_values = [p.strip() for p in pitch.split(',')]
            processed_pitch_values = []
            for p in pitch_values:
                if p in pitch_mapping:
                    processed_pitch_values.append(pitch_mapping[p])
                else:
                    try:
                        processed_pitch_values.append(int(p))
                    except ValueError:
                        processed_pitch_values.append(100)
            if len(processed_pitch_values) == 1:
                entry['pitch'] = processed_pitch_values[0]
            else:
                entry['pitch'] = processed_pitch_values
        else:
            entry['pitch'] = None

def generate_lua(entries, output_filename):
    with open(output_filename, 'w') as f:
        for entry in entries:
            f.write('sound.Add( {\n')
            f.write(f'\tname = "{entry["name"]}",\n')
            if 'channel' in entry:
                f.write(f'\tchannel = {entry["channel"]},\n')
            f.write(f'\tvolume = {entry["volume"]},\n')
            f.write(f'\tlevel = {entry["level"]},\n')
            if entry.get('pitch') is not None:
                if isinstance(entry['pitch'], list):
                    f.write(f'\tpitch = {{{entry["pitch"][0]}, {entry["pitch"][1]}}},\n')
                else:
                    f.write(f'\tpitch = {entry["pitch"]},\n')
            
            # Handle sound output
            if 'sound' in entry:
                sounds = entry['sound']
                if isinstance(sounds, list) and len(sounds) > 1:
                    f.write('\tsound = {\n')
                    for s in sounds:
                        f.write(f'\t\t"{s}",\n')
                    f.write('\t},\n')
                elif isinstance(sounds, list) and len(sounds) == 1:
                    f.write(f'\tsound = "{sounds[0]}",\n')
                else:
                    f.write(f'\tsound = "{sounds}",\n')
            else:
                f.write('\tsound = "",\n')
            f.write('} )\n\n')

def main():
    import sys
    if len(sys.argv) < 3:
        print("Usage: python script.py input.txt output.lua [prefix] [path_prefix]")
        return

    input_filename = sys.argv[1]
    output_filename = sys.argv[2]
    global path_prefix

    if len(sys.argv) >= 4:
        prefix = sys.argv[3]
    else:
        prefix = 'MCV_'

    if len(sys.argv) >= 5:
        path_prefix = sys.argv[4]
    else:
        path_prefix = 'mcv/'

    if not prefix.endswith('_'):
        prefix += '_'

    entries = parse_soundscript(input_filename)
    process_entries(entries, prefix, path_prefix)
    generate_lua(entries, output_filename)
    print(f"Generated {output_filename} with prefix '{prefix}' and path prefix '{path_prefix}'")

if __name__ == "__main__":
    main()