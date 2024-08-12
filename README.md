
**File Transliterator Script**
=============================

This script is designed to transliterate file names from Cyrillic to Latin characters. It can also replace spaces with dashes or underscores and convert file names to lowercase.

### Usage

To use this script, simply run it from the command line, providing the source folder containing the files to be transliterated as the first argument. Optionally, you can provide a destination folder as the second argument. If no destination folder is provided, the script will use the source folder.

### Options

The script accepts the following options:

* `--replace-space dash|underscore`: Replace spaces in file names with dashes or underscores.
* `--lowercase`: Convert file names to lowercase.

### Example Usage

- To transliterate files in the same folder without additional options:
```bash
./transliterator.sh /path/to/source_folder 
```
- To transliterate files and replace spaces with dashes:
```bash
./transliterator.sh /path/to/source_folder /path/to/destination_folder --replace-space dash
```
- To transliterate files and replace spaces with underscores:
```bash
./transliterator.sh /path/to/source_folder /path/to/destination_folder --replace-space underscore
```
- To rename files and convert filenames to lowercase:
```bash
./transliterator.sh /path/to/source_folder /path/to/destination_folder --lowercase
```
- To combine options, such as replacing spaces with underscores and converting to lowercase:
```bash
./transliterator.sh /path/to/source_folder /path/to/destination_folder --replace-space underscore --lowercase
```
