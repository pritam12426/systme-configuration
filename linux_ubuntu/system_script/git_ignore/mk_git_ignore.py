#!/usr/bin/python3

import os.path
from os import getcwd, listdir

if ".git" not in listdir("."):
	print("fatal: not a git repository (or any of the parent directories): .git")
	exit(1)

from sys import path
from requests import get, exceptions
from pyfzf import FzfPrompt  # pip install pyfzf

fzf: FzfPrompt = FzfPrompt('/bin/sk')  # Enter your path of 'fzf' or 'skim'


def get_info(_text_content: str) -> list[str]:
	new_list: list[str] = []
	for _i in fzf.prompt(_text_content, fzf_options="-m --prompt='Select your LDE and language >> '", delimiter=""):
		new_list.append(_i.split(" | ", 1)[-1])

	return sorted(new_list)


with open(path[0] + "/supported_template.txt", "rt") as f:
	support_template: str = f.read()

url: list[str] = get_info(support_template)

if "None" in url or len(url) == 0:
	exit(0)


try:
	web_data: str = get(f"https://www.toptal.com/developers/gitignore/api/{','.join(url).lower()}").text
except exceptions.ConnectionError:
	print("Check your network.\a")
	exit(1)

url: str = ""

for i in web_data.split("\n")[3: -2]:
	url += i + "\n"
url += "# Some ignore file and folder.\n*temp*\ntest/\n"

with open(".gitignore", "w") as f:
	f.write(url)

print(f"Add '.gitignore' in '{getcwd()}'")
