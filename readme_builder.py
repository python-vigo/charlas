import pathlib
import re
import typing
from dataclasses import dataclass

class TalkParseError(Exception):
    """Exception raised when parsing a talk directory name fails."""
    pass

TALK_TYPE_ICONS = {
    "lightning": "⚡",
    "relámpago": "⚡",
    "charla": "🗣️",
    "talk": "🗣️",
    "workshop": "🛠️",
    "taller": "🛠️"
}

@dataclass
class Talk:
    """
    Represents a talk with its details.
    """
    date: str
    title: str
    talk_type: str
    speaker: str

    @classmethod
    def from_directory_name(cls, dir_name: str) -> 'Talk':
        """
        Create a Talk object from a directory name.

        Args:
            dir_name (str): The name of the directory to parse.

        Returns:
            Talk: A Talk object with extracted information.

        Raises:
            TalkParseError: If the directory name doesn't match the expected format.
        """
        pattern = r"(\d{4}-\d{2}-\d{2}) - (.+) \[(.+)\] - (.+)"
        match = re.match(pattern, dir_name)
        if match:
            return cls(*match.groups())
        raise TalkParseError(f"❌ Failed to parse: {dir_name}")

    def to_rst_row(self) -> str:
        """
        Convert the Talk object to an RST table row.

        Returns:
            str: RST formatted table row.
        """
        icon = TALK_TYPE_ICONS.get(self.talk_type.lower(), "❓")
        tooltip = f':tooltip:`<span title="{self.talk_type}">{icon}</span>`'
        return f"   * - {self.date}\n     - {tooltip}\n     - {self.title}\n     - {self.speaker}\n"

def read_description_file(repo_path: pathlib.Path) -> str:
    """
    Read the content of docs/description.rst file.

    Args:
        repo_path (pathlib.Path): Path to the repository root.

    Returns:
        str: Content of the description file or empty string if file not found.
    """
    description_path = repo_path / "docs" / "description.rst"
    if description_path.exists():
        return description_path.read_text(encoding="utf-8")
    return ""

def generate_readme_content(talks: typing.List[Talk], repo_path: pathlib.Path) -> str:
    """
    Generate the content for the README.rst file.

    Args:
        talks (List[Talk]): List of Talk objects.
        repo_path (pathlib.Path): Path to the repository root.

    Returns:
        str: The content for the README.rst file.
    """
    header = b""".. |travis_badge| image:: https://travis-ci.com/python-vigo/charlas.svg?branch=master
    :target: https://travis-ci.com/python-vigo/charlas

.. |repo_size_badge| image:: https://img.shields.io/github/repo-size/python-vigo/charlas.svg

|travis_badge| |repo_size_badge|


"""

    description = read_description_file(repo_path)

    content = [
        header.decode('utf-8'),
        description,
        ".. role:: tooltip(raw)",
        "   :format: html",
        "",
        ".. list-table:: Example Table",
        "   :header-rows: 1",
        "",
        "   * - Fecha",
        "     - Tipo",
        "     - Título",
        "     - Ponente",
        ""
    ]

    for talk in talks:
        content.append(talk.to_rst_row())

    return "\n".join(content)

def main() -> None:
    """
    Main function to read directories and create README.rst file.
    """
    repo_path = pathlib.Path.cwd()
    talks = []

    # Sort directories in reverse order (newest first)
    for dir_path in sorted(repo_path.iterdir(), reverse=True):
        if not dir_path.is_dir() or dir_path.name.startswith(".") or dir_path.name in ["docs"]:
            continue
        try:
            talk = Talk.from_directory_name(dir_path.name)
            talks.append(talk)
        except TalkParseError as e:
            print(str(e))

    readme_content = generate_readme_content(talks, repo_path)

    readme_path = repo_path / "README.rst"
    readme_path.write_text(readme_content, encoding="utf-8")

    print(f"README.rst has been created at {readme_path}")

if __name__ == "__main__":
    main()
