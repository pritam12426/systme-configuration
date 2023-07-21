#!/usr/bin/python3
# -*- coding: utf-8 -*-

from os import getcwd, listdir

if ".git" not in listdir("."):
	print("No! This is not a git 'repository'.")
	exit(1)

from tomllib import load
from sys import path
from requests import get, exceptions


def get_info(toml_data: list[str], fun_type: str) -> list[str]:
	toml_data: list[str] = sorted(toml_data, key=len)
	for _index, _i in enumerate(toml_data, start=1):
		print(f"{_index:0>2} 🠪 {_i}")

	user: str = input(f"\nEnter 'So numbers' for {fun_type} >> ").removesuffix(" ")

	if user != "":
		new_list: list[str] = []
		for _i in user.split(" "):
			try:
				new_list.append(toml_data[(int(_i) - 1)])
			except IndexError:
				print(f"{_i} is out of range.")
				exit(1)
	else:
		new_list: list[str] = ["~"]

	return sorted(new_list)


with open(path[0] + "/data.toml", "rb") as f:
	toml_content: dict = load(f)

url: list[str] = []

url.extend(get_info(toml_content.pop("ide"), "IDE"))
url.extend(get_info(toml_content.pop("language"), "LANGUAGE"))

if url == ["~", "~"]:
	exit(1)

if "~" in url:
	url.remove("~")

try:
	web_data: str = get(f"https://www.toptal.com/developers/gitignore/api/{','.join(url).lower()}").text
except exceptions.ConnectionError:
	print("Check your network.")
	exit(1)

url: str = ""

for i in web_data.split("\n")[3: -2]:
	url += i + "\n"
url += "# Some ignore file and folder.\n*temp*\nrubbish/\n"

with open(".gitignore", "a") as f:
	f.write(url)

print(f"Add '.gitignore' in '{getcwd()}'")
