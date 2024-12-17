import os
import shutil
import magic
import logging
from datetime import datetime
import re
import threading

def create_folders():
    folders = ['Text', 'Images', 'Scripts', 'Other']
    for folder in folders:
        if not os.path.exists(folder):
            os.makedirs(folder)

def get_file_type(file_path):
    file_mime = magic.Magic(mime=True)
    mime_type = file_mime.from_file(file_path)
    if 'text' in mime_type:
        return 'Text'
    elif 'image' in mime_type:
        return 'Images'
    elif 'script' in mime_type or 'x-python' in mime_type:
        return 'Scripts'
    else:
        return 'Other'

def organize_files(source_dir, max_recursion_depth, max_file_size, exclude_patterns, rename_pattern, interactive_mode):
    logger.info("Organizing files from directory: %s", source_dir)
    for root, dirs, files in os.walk(source_dir):
        current_depth = root.count(os.sep) - source_dir.count(os.sep)
        if max_recursion_depth is not None and current_depth > max_recursion_depth:
            continue
        for file in files:
            file_path = os.path.join(root, file)
            file_size = os.path.getsize(file_path) / (1024 * 1024)  # in MB
            if max_file_size is not None and file_size > max_file_size:
                logger.warning("File %s exceeds maximum size limit and will be ignored.", file_path)
                continue
            if any(re.match(pattern, file) for pattern in exclude_patterns):
                logger.info("File %s matches exclude pattern and will be ignored.", file_path)
                continue
            file_type = get_file_type(file_path)
            if file_type:
                destination_folder = os.path.join(os.getcwd(), file_type)
                if not os.path.exists(destination_folder):
                    os.makedirs(destination_folder)
                destination_path = os.path.join(destination_folder, file)
                if os.path.exists(destination_path):
                    if interactive_mode:
                        response = input(f"File '{file}' already exists in '{destination_folder}'. Overwrite? (y/n): ")
                        if response.lower() != 'y':
                            logger.info("User chose not to overwrite file %s", file_path)
                            continue
                    else:
                        # Rename file to avoid overwriting
                        file_name, file_extension = os.path.splitext(file)
                        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
                        new_file_name = f"{file_name}_{timestamp}{file_extension}"
                        destination_path = os.path.join(destination_folder, new_file_name)
                        logger.warning("Duplicate file found. Renaming %s to %s", file, new_file_name)
                if rename_pattern:
                    new_file_name = re.sub(r'{original_name}', file, rename_pattern)
                    destination_path = os.path.join(destination_folder, new_file_name)
                shutil.move(file_path, destination_path)
                logger.info("Moved %s to %s", file, destination_path)

if __name__ == "__main__":
    # Setting up logging
    logging.basicConfig(filename='file_organizer.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    logger = logging.getLogger()

    print("Welcome to File Organizer!")
    source_directory = input("Enter the directory to organize files from: ")

    if not os.path.exists(source_directory):
        print("Error: Directory not found.")
        logger.error("Directory not found: %s", source_directory)
    else:
        max_recursion_depth = int(input("Enter the maximum recursion depth (Enter 0 for no limit): "))
        max_file_size = float(input("Enter the maximum file size limit in MB (Enter 0 for no limit): "))
        exclude_patterns = input("Enter file patterns to exclude (comma-separated, e.g., *.log,*.tmp): ").split(',')
        rename_pattern = input("Enter file renaming pattern (use '{original_name}' to refer to the original filename, leave empty for no renaming): ")
        interactive_mode = input("Enable interactive mode? (y/n): ").lower() == 'y'

        create_folders()
        organize_files(source_directory, max_recursion_depth, max_file_size, exclude_patterns, rename_pattern, interactive_mode)
        print("Files organized successfully!")
        logger.info("Files organized successfully!")
