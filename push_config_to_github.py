#!/Library/Frameworks/Python.framework/Versions/3.12/bin/python3
# -*- coding: utf-8 -*-

# Ignore this file
# This is my personal python script
# That can capable for finding changes in my 'config' files
# And pushing to github


import os
import git  # pip install git-python
from yaml import safe_load  # pip install pyyaml
from hashlib import sha256
from shutil import copy


def find_checksum(file_path: str) -> str:
	hasher = sha256()
	with open(file_path, "rb") as file:
		f_content = file.read()
		hasher.update(f_content)
	return hasher.hexdigest()


def get_last_commit_datetime(file_path: str, repo: git) -> str:
	try:
		commit_msg: git = next(repo.iter_commits(paths=file_path, max_count=1))
	except Exception:
		return "*" * 20
	commit_msg: str = str(commit_msg.committed_datetime)[:19]
	date_time: list[str] = commit_msg.split(" ")
	return "||".join(date_time)


def get_uncommitted_files(repo: git) -> list[str] | None:
	uncommitted_files: list[str] = []
	for file in repo.untracked_files:
		uncommitted_files.append(file)
	for file in repo.index.diff(None):
		uncommitted_files.append(file.a_path)
	if len(uncommitted_files) == 0:
		return None
	else:
		return sorted(uncommitted_files, key=len)


def status(file_name: str, get_status: str, columns_size: int, date_time: str = "-" * 20) -> str:
	string_side: int = columns_size - 40
	match get_status:
		case "FILE NOT FOUND":
			sine: str = "✘"
		case "UPDATED":
			sine: str = "✔"
		case "UP TO DATE":
			sine: str = ""
		case "COPIED":
			sine: str = ""
		case _:
			sine: str = "-"

	if len(file_name) > string_side:
		file_name = "..." + file_name[-(string_side - 3):]

	return f"|{sine} {get_status:14}|{file_name:{string_side}}|{date_time:20}|"


def file_or_not(file_path: str, columns_size: int = 42) -> bool:
	if os.path.exists(file_path):
		if os.path.isfile(file_path):
			return True
		else:
			return False
	print(status(file_path, "FILE NOT FOUND", columns_size))


with open("/Users/pritam/Developer/system_script/file_path.yaml", "r") as file_content:
	all_path: dict = safe_load(file_content)

git_dir: str = all_path.pop("git_dir")

local_repo: git = git.Repo(git_dir)

terminal_size: int = os.get_terminal_size().columns
# terminal_size: int = 110

print(f"|{' STATUS ':-^16}|{' FILE ':-^{terminal_size - 40}}|{' DATE AND TIME ':-^20}|")

for i in sorted(all_path.keys()):
	if file_or_not(all_path.get(i).get("sys_dir") + i, terminal_size):
		content: dict = all_path.get(i)
		if not os.path.exists(git_dir + content.get("gdir")):
			os.makedirs(git_dir + content.get("gdir"))
		if not os.path.exists(git_dir + content.get("gdir") + content.get("new_name", i)):
			copy(content.get("sys_dir") + i, git_dir + content.get("gdir") + content.get("new_name", i))
			print(status(content.get("sys_dir") + i, "COPIED", terminal_size))
		elif find_checksum(content.get("sys_dir") + i) != find_checksum(
				git_dir + content.get("gdir") + content.get("new_name", i)):
			copy(content.get("sys_dir") + i, git_dir + content.get("gdir") + content.get("new_name", i))
			date: str = get_last_commit_datetime(git_dir + content.get("gdir") + content.get('new_name', i), local_repo)
			print(status(content.get("sys_dir") + i, "UPDATED", terminal_size, date))
		else:
			date: str = get_last_commit_datetime(git_dir + content.get("gdir") + content.get('new_name', i), local_repo)
			print(status(content.get("sys_dir") + i, "UP TO DATE", terminal_size, date))
print("-" * terminal_size)

uncommitted_file: list[str] | None = get_uncommitted_files(local_repo)
if uncommitted_file is not None:
	print(f"Uncommitted files 󰜴 {uncommitted_file}\n")
	match input(f"Wants to commit '{len(uncommitted_file)}' files [y/n] >> "):
		case "y":
			commit: str = input("Any custom commit >> ")
			match commit:
				case "":
					commit += commit
					gap: str = "\n\n"
				case _:
					commit = "\n\n" + commit + "\n\n"
					gap: str = "\n"

			commit += f"Make Change In >>{gap}{' '*16} - ./"
			commit += f"\n{' '*16} - ./".join(uncommitted_file)
			local_repo.index.add(["*"])
			local_repo.index.commit(commit)
			match input("Wants to push change [y/n] >> "):
				case "y":
					local_repo.remote("origin").push()
					print("Done.")
				case _:
					print("ABORT PUSHING.")
		case _:
			print("ABORT COMMITTING.")
else:
	print("NO CHANGES FOUND.")
