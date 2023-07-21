#!/usr/bin/python3
# -*- coding: utf-8 -*-

# Command line media player by using ffplay lib.

import os
from subprocess import run
from random import choice
from sys import platform


def find_high_equal(text: list[str]) -> int:
	max_number = int()
	for i in text:
		if len(i) > max_number:
			max_number = len(i)
	return max_number


def get_title(raw_name: str) -> str:
	name = raw_name.rsplit(".", maxsplit=1)[0].replace("_", " ")

	if len(name) >= 42:
		name = name[:42] + "..."
	else:
		name = name + " ~"

	return f"~ {name.upper()}"


def find_type_system() -> tuple:
	if platform == "win32":
		return "cls", "\\"

	elif platform == "linux" or platform == "darwin":  # Darwin is for mac os
		return "clear", "/"

	else:
		exit("Unsupported system")


os.chdir(os.getcwd())
all_file: list[str] = sorted([i for i in os.listdir() if i.endswith((".mp4", ".mkv", ".mp3", ".m4a"))])

if len(all_file) != 0:
	number_of_equal: int = find_high_equal(all_file)
	element_len: int = len(str(len(all_file)))
	while True:
		user_input: str = input(f"Enter 'so/no' in between '0 to {len(all_file) - 1}' >> ").lower()

		if user_input == "exit" or user_input == "q":
			exit(0)

		elif user_input == "clear":
			os.system(find_type_system()[0])
			continue

		elif user_input == "":
			continue

		elif user_input.startswith("rm "):
			user_input: str = user_input.removeprefix("rm ")
			if user_input.isdigit() and int(user_input) <= (len(all_file) - 1):
				if user_input.isdigit():
					os.remove(all_file[int(user_input)])
					print(f" ● Deleted '{all_file[int(user_input)]}'.")
					all_file.remove(all_file[int(user_input)])
			continue

		elif user_input.startswith("/"):
			os.system(find_type_system()[0])
			element: str = user_input.removeprefix("/")

			element_content: str = f" Search log for >> '{element}' ".center(number_of_equal + 5 + element_len, "=")
			print(element_content)

			for i in all_file:
				name: str = i.rsplit(".")[0].replace("_", " ")
				extension: str = i.rsplit(".")[1]
				if element.casefold() in name.replace("_", " ").casefold():
					print(f" ● {all_file.index(i):{element_len}} > {all_file[all_file.index(i)]}")
			print("=" * (number_of_equal + 5 + element_len))
			continue

		elif user_input == "ls":
			os.system(find_type_system()[0])

			element_len: int = len(str(len(all_file)))
			print(" directory contents ".center(number_of_equal + 5 + element_len, "="))

			for index, i in enumerate(all_file):
				print(f"{index:{element_len}} >>> {i}")

			print("=" * (number_of_equal + 5 + element_len))
			continue

		elif user_input == "r":
			command: str = choice(all_file)
			element: str = f"● SO/no >> '{all_file.index(command)}' > '{command}'"

			print(element)
			print("=" * len(element))

		elif user_input.isdigit():
			if int(user_input) > ((len(all_file)) - 1):
				print(f"'{user_input}' out of ranger.")
				continue

			else:
				command: str = all_file[int(user_input)]

		else:
			print("Invalid input.")
			continue

		run(["ffplay", "-window_title", f"{get_title(command)}", "-loop", "-1", command], capture_output=True)

else:
	exit(f"There is not media file in '{os.getcwd()}'")
