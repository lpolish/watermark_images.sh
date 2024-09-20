# Image Watermarker

![Example](https://github.com/user-attachments/assets/0116dcc1-a297-4466-b37e-998704fb95eb)

A bash script to add subtle watermarks to images in a directory.

## Features

- Adds watermark text to multiple positions on each image
- Supports JPG, JPEG, PNG, and GIF formats
- Adjustable opacity and font size
- Processes all images in a specified directory

## Requirements

- Bash shell
- ImageMagick

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/lpolish/watermark_images.sh.git
   ```
2. Make sure ImageMagick is installed on your system. If not, install it:
   - On Ubuntu/Debian: `sudo apt-get install imagemagick`
   - On macOS with Homebrew: `brew install imagemagick`

## Usage

1. Make the script executable:
   ```
   chmod +x watermark_images.sh
   ```
2. Run the script:
   ```
   ./watermark_images.sh /path/to/your/images "Your Watermark Text"
   ```

## Customization

You can adjust the following parameters in the script:
- Opacity: Change `rgba(255,255,255,0.1)` to increase or decrease opacity
- Font size: Modify `-pointsize 20` to change the size of the watermark text
- Position: Adjust the `+10+10` values in the `-annotate` options to change positioning

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgements

- [ImageMagick](https://imagemagick.org/) for image processing capabilities
