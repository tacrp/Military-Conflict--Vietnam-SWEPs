import os
import openai
import re
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Set up OpenAI client
client = openai.OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

def read_txt_file(file_path):
    with open(file_path, 'r') as file:
        return file.read()

def write_lua_file(file_path, content):
    with open(file_path, 'w') as file:
        file.write(content)

def convert_txt_to_lua(txt_content):
    prompt = f"""
Convert the following TXT game definition to Lua format:

{txt_content}

Use the following guidelines and examples for the conversion:

1. The Lua file should start with 'SWEP.Base = "mcv_base"' and 'SWEP.Spawnable = true'.
2. Convert WeaponData block to individual SWEP assignments.
3. Convert string values to use double quotes.
4. Convert numeric values to Lua number format.
5. Convert boolean values to Lua boolean format (true/false).
6. Convert arrays to Lua tables.
7. Ignore comments in the TXT file.
8. Use appropriate Lua syntax for nested structures.
9. Ensure all values are properly assigned to SWEP properties.

Examples:

TXT:
```
WeaponData
{{
    "printname"     "#weapon_KAR98K_s"
    "origin"        "#nazi_germany"
    "viewmodel"     "models/weapons/v_kar98_s.mdl"
    "playermodel"       "models/weapons/w_kar98_s.mdl"
    "anim_prefix"       "boltaction"
    "bucket"        "0"
    "bucket_position"       "0"
    "clip_size"     "5/15"
    "primary_ammo"      "7.92x57"
    "secondary_ammo"        "None"
    "weight"        "3.7"
    "item_flags"        "0"
}}
```

Lua:
```lua
SWEP.Base = "mcv_base"
SWEP.Spawnable = true

SWEP.PrintName = "#weapon_KAR98K_s"
SWEP.Origin = "#nazi_germany"
SWEP.ViewModel = "models/weapons/v_kar98_s.mdl"
SWEP.WorldModel = "models/weapons/w_kar98_s.mdl"
SWEP.AnimPrefix = "boltaction"
SWEP.Bucket = 0
SWEP.BucketPosition = 0
SWEP.ClipSize = 5
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 15
SWEP.Primary.Ammo = "7.92x57"
SWEP.Secondary.Ammo = "None"
SWEP.Weight = 3.7
SWEP.ItemFlags = 0
```

TXT:
```
"Firemodes"     "Semi"
"IronSight"     "1"
"HasScope"      "1"
"ScopeLensFov"      "8"
"ScopeLensFov2"     "4"
```

Lua:
```lua
SWEP.Firemodes = "FIREMODE_SEMI"
SWEP.Ironsight = true
SWEP.HasScope = true
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4
```

TXT:
```
SoundData
{{
    "single_shot"       "Weapon_KAR98K.Single"
    "empty"         "Weapon_Generic.ClipEmpty_06"
}}
```

Lua:
```lua
SWEP.SoundSingleShot = "Weapon_KAR98K.Single"
SWEP.SoundEmpty = "Weapon_Generic.ClipEmpty_06"
```

Please provide only the converted Lua code without any explanations.
"""

    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[
            {"role": "system", "content": "You are a helpful assistant that converts game weapon definitions from TXT format to Lua format."},
            {"role": "user", "content": prompt}
        ]
    )

    lua_content = response.choices[0].message.content.strip()

    # Post-process the Firemodes
    lua_content = re.sub(r'SWEP.Firemodes = "FIREMODE_(\w+)"', 
                         r'SWEP.Firemodes = {\n    MCV.FIREMODE_\1\n}', 
                         lua_content)

    return lua_content

def process_directory(input_dir, output_dir):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for filename in os.listdir(input_dir):
        if filename.endswith(".txt"):
            print(f"Converting {filename} now...")
            txt_path = os.path.join(input_dir, filename)
            lua_filename = os.path.splitext(filename)[0] + ".lua"
            lua_path = os.path.join(output_dir, lua_filename)

            txt_content = read_txt_file(txt_path)
            lua_content = convert_txt_to_lua(txt_content)
            write_lua_file(lua_path, lua_content)

            print(f"Converted {filename} to {lua_filename}")

if __name__ == "__main__":
    input_directory = "work/cscripts"
    output_directory = "work/lua"
    process_directory(input_directory, output_directory)