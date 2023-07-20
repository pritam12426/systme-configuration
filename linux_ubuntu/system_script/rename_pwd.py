#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import re  # Regular expression

if os.getcwd() == os.getenv("HOME"):
	exit("This is 'HOME' directory.")

if os.getenv("HOME") not in os.getcwd():
	exit("This is 'ROOT' directory.")


def remove_underscore(text: str) -> str:
	new_text: str = re.sub(r"[^\x00-\x7F]+", " ", text)
	new_text: str = re.sub("_+", " ", new_text)
	new_text: str = re.sub(" +", "_", new_text)

	for _i in list(r"!#$%&'()*+,-./:;<=>?@[]^_`{|}~"):
		if f"_{_i}" in new_text:
			new_text: str = new_text.replace(f"_{_i}", f"{_i}")

		if f"{_i}_" in new_text:
			new_text: str = new_text.replace(f"{_i}_", f"{_i}")

		if f"{_i + _i}" in new_text:
			new_text: str = new_text.replace(f"{_i + _i}", _i)
	new_text: str = new_text.replace(".", "_")

	return new_text.removesuffix("_").removeprefix("_").lower()


def rename_file(old_name: str) -> str:
	split_name: list[str] = old_name.rsplit(".", maxsplit=1)
	return f"{remove_underscore(split_name[0])}.{split_name[1]}".lower()


def get_dict(list_of_content: list[str]) -> dict:
	result: dict = {}

	file: int = 0
	folder: int = 0
	hidden_file: int = 0
	hidden_folder: int = 0
	unknown: int = 0
	untouched: int = 0

	for _i in sorted(list_of_content):
		if not _i.startswith("."):
			if os.path.isfile(_i):
				if "." in _i:
					new_file_name: str = rename_file(_i)
					if _i != new_file_name:
						result |= {_i: new_file_name}
						file += 1
					else:
						untouched += 1
				else:
					unknown += 1
			elif os.path.isdir(_i):
				new_dir_name: str = remove_underscore(_i)
				if _i != new_dir_name:
					result |= {_i: new_dir_name}
					folder += 1
				else:
					untouched += 1
		else:
			untouched += 1
			if os.path.isfile(_i):
				hidden_file += 1
			else:
				hidden_folder += 1

		result |= {
			"int_value": {
				"total_rename": file + folder,
				"renamed_file": file,
				"renamed_folder": folder,
				"hidden": hidden_file + hidden_folder,
				"hidden_file": hidden_file,
				"hidden_folder": hidden_folder,
				"unknown": unknown,
				"untouched": untouched,
				"total": len(list_of_content)
			}
		}
	return result


all_file: list[str] = os.listdir()
new_name: dict = get_dict(all_file)
int_value: dict = new_name.pop("int_value")

if len(new_name.keys()) == 0:
	exit(f"Nothing to change in '{int_value.get('total')}' items.")

if ".git" in all_file:
	print("Sorry! This is a 'git-REPOSITORY'.")
	print(f" {int_value.get('file')} files, and {int_value.get('folder')} folder, will get effected.")
	for i in new_name.keys():
		print(f"  ● {i}")

	if input("\nWants to continue? [y/n] ").casefold() == "n":
		exit("ABORT RENAMING PWD")
	else:
		print("\n")

for i in new_name.keys():
	os.rename(i, new_name.get(i))
	# print(f"{i} 🠪 {new_name.get(i)}")

# pass
# "🖿 ☶"

print(f"{'RENAMED:':13}{int_value.get('total_rename')}\n\t{'☶  File:':12}{int_value.get('renamed_file')}\n"
      f"\t{'🖿  Folder:':12}{int_value.get('renamed_folder')}\n"
      f"{'HIDDEN:':13}{int_value.get('hidden')}\n\t{'☶  File:':12}{int_value.get('hidden_file')}\n"
      f"\t{'🖿  Folder:':12}{int_value.get('renamed_folder')}\n"
      f"{'Untouched:':13}{int_value.get('untouched')}\n"
      f"{'Unknown:':13}{int_value.get('unknown')}\n"
      f"{'Total:':13}{int_value.get('total')}".expandtabs(1))
