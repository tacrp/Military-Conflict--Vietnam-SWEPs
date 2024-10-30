import os
from PIL import Image
from pathlib import Path
import subprocess
import re
import xml.etree.ElementTree as ET
import tempfile

def modify_svg_colors(svg_path):
    """
    Modify SVG content to change all colors to white
    """
    # Parse the SVG file
    tree = ET.parse(svg_path)
    root = tree.getroot()
    
    # Function to process an element
    def process_element(element):
        # List of attributes to check for colors
        color_attrs = ['fill', 'stroke']
        
        # Process this element's attributes
        for attr in color_attrs:
            if attr in element.attrib:
                # Skip if already transparent
                if element.attrib[attr].lower() in ['none', 'transparent']:
                    continue
                element.attrib[attr] = 'white'
        
        # Process style attribute if it exists
        if 'style' in element.attrib:
            style = element.attrib['style']
            # Replace colors in style attribute
            style = re.sub(r'fill:#[0-9a-fA-F]{3,6}', 'fill:#ffffff', style)
            style = re.sub(r'stroke:#[0-9a-fA-F]{3,6}', 'stroke:#ffffff', style)
            element.attrib['style'] = style
        
        # Process all child elements
        for child in element:
            process_element(child)
    
    # Process the entire SVG
    process_element(root)
    
    # Save to temporary file
    temp_svg = svg_path.parent / f"temp_{svg_path.name}"
    tree.write(temp_svg)
    return temp_svg

def convert_svg_to_png(svg_path, output_path, size=(256, 256)):
    """
    Convert SVG to PNG with specific requirements using Inkscape:
    - 256x256 output size
    - Transparent background
    - White fill color
    - Centered image
    
    Args:
        svg_path (str): Path to input SVG file
        output_path (str): Path for output PNG file
        size (tuple): Output image size (width, height)
    """
    svg_path = Path(svg_path)
    output_path = Path(output_path)
    
    # Create a temporary directory for intermediate files
    with tempfile.TemporaryDirectory() as temp_dir:
        temp_dir = Path(temp_dir)
        
        # Modify colors to white
        temp_svg = modify_svg_colors(svg_path)
        
        # First convert to PNG with Inkscape
        temp_png = temp_dir / "temp.png"
        
        # Construct Inkscape command
        inkscape_cmd = [
            "inkscape",
            "--export-type=png",
            f"--export-filename={temp_png}",
            str(temp_svg)
        ]
        
        # Run Inkscape command
        try:
            subprocess.run(inkscape_cmd, check=True, capture_output=True, text=True)
        except subprocess.CalledProcessError as e:
            print(f"Inkscape error: {e.stderr}")
            raise
        finally:
            # Clean up temporary SVG
            temp_svg.unlink()
        
        # Open with Pillow for final processing
        img = Image.open(temp_png)
        
        # Convert to RGBA if not already
        if img.mode != 'RGBA':
            img = img.convert('RGBA')
        
        # Create new transparent image with desired size
        new_img = Image.new('RGBA', size, (0, 0, 0, 0))
        
        # Calculate scaling factor to fit within bounds while maintaining aspect ratio
        img_ratio = min(size[0] / img.width, size[1] / img.height)
        new_size = (int(img.width * img_ratio), int(img.height * img_ratio))
        img = img.resize(new_size, Image.Resampling.LANCZOS)
        
        # Calculate position to center the resized image
        x = (size[0] - new_size[0]) // 2
        y = (size[1] - new_size[1]) // 2
        
        # Paste the resized image onto the new background
        new_img.paste(img, (x, y), img)
        
        # Save the final image
        new_img.save(output_path, 'PNG')

def batch_convert_directory(input_dir, output_dir):
    """
    Convert all SVG files in a directory to PNGs with specified requirements.
    
    Args:
        input_dir (str): Directory containing SVG files
        output_dir (str): Directory for output PNG files
    """
    # Create output directory if it doesn't exist
    Path(output_dir).mkdir(parents=True, exist_ok=True)
    
    # Process all SVG files in the input directory
    for svg_file in Path(input_dir).glob('*.svg'):
        output_file = Path(output_dir) / f"{svg_file.stem}.png"
        try:
            convert_svg_to_png(str(svg_file), str(output_file))
            print(f"Converted {svg_file.name} -> {output_file.name}")
        except Exception as e:
            print(f"Error converting {svg_file.name}: {str(e)}")

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='Convert SVG files to centered 256x256 PNGs')
    parser.add_argument('input_dir', help='Directory containing SVG files')
    parser.add_argument('output_dir', help='Directory for output PNG files')
    
    args = parser.parse_args()
    
    batch_convert_directory(args.input_dir, args.output_dir)