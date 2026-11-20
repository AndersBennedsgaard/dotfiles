import argparse
import json
import pathlib
import subprocess

parser = argparse.ArgumentParser(prog="lazy changelog generator")
parser.add_argument("--old-lock", required=True)
parser.add_argument("--new-lock", required=True)
parser.add_argument("--out", required=True)

args = parser.parse_args()

old_lock = pathlib.Path(args.old_lock)
new_lock = pathlib.Path(args.new_lock)
out_file = pathlib.Path(args.out)

lazy_dir = pathlib.Path(".local/share/nvim/lazy")

with old_lock.open("r", encoding="utf-8") as f:
    old = json.load(f)

with new_lock.open("r", encoding="utf-8") as f:
    new = json.load(f)


def write_plugin_header(out, plugin):
    out.write(f"## {plugin}\n\n")


with out_file.open("w", encoding="utf-8") as out:
    out.write("# lazy.nvim plugin updates\n\n")

    changed = False

    # Added plugins
    for plugin in sorted(new.keys() - old.keys()):
        changed = True
        write_plugin_header(out, plugin)
        out.write("New plugin.\n\n")

    # Removed plugins
    for plugin in sorted(old.keys() - new.keys()):
        changed = True
        write_plugin_header(out, plugin)
        out.write("Plugin removed.\n\n")

    # Updated plugins
    for plugin in sorted(old.keys() & new.keys()):
        old_commit = old[plugin]["commit"]
        new_commit = new[plugin]["commit"]

        if old_commit == new_commit:
            continue

        changed = True

        write_plugin_header(out, plugin)

        out.write(
            f"`{old_commit[:8]}` → `{new_commit[:8]}`\n\n"
        )

        repo = lazy_dir / plugin

        if not repo.exists():
            out.write("_Repository not found locally; commit history unavailable._\n\n")
        else:
            result = subprocess.run(
                [
                    "git",
                    "-C",
                    str(repo),
                    "log",
                    "--reverse",
                    "--oneline",
                    "--no-merges",
                    "--max-count=30",
                    "--format=%h %s",
                    f"{old_commit}..{new_commit}",
                ],
                capture_output=True,
                text=True,
                check=False,
            )

            if result.returncode != 0:
                out.write("_Could not retrieve commit history._\n\n")
            elif result.stdout.strip():
                out.write("```text\n")
                out.write(result.stdout)
                out.write("```\n\n")
            else:
                out.write("_No commits found._\n\n")

        compare_url = (
            f"https://github.com/{plugin}/compare/"
            f"{old_commit}...{new_commit}"
        )

        out.write(
            f"Compare: [{old_commit[:8]}...{new_commit[:8]}]"
            f"({compare_url})\n\n"
        )

    if not changed:
        out.write("No plugin updates.\n")

