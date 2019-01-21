#!/usr/bin/env python3
import shutil
from pathlib import Path
from urllib.parse import quote


def build_index():
    talks, max_talk_lengths, folder_names = get_talks_metadata()

    # Add extra space to save space for hyperlinks syntax: ``_
    max_talk_date_length = max_talk_lengths[0] + 10
    max_talk_title_length = max_talk_lengths[1] + 10
    max_talk_type_length = max_talk_lengths[2] + 10
    max_talk_speaker_length = max_talk_lengths[3] + 10

    with open('./docs/index.rst', 'w') as indexfile:
        separator = (
                '='*max_talk_date_length + ' ' +
                '='*max_talk_title_length + ' ' +
                '='*max_talk_type_length + ' ' +
                '='*max_talk_speaker_length + '\n'
        )
        indexfile.write("\n")
        indexfile.write(separator)
        indexfile.write(
            'Fecha'.ljust(max_talk_date_length) + ' ' +
            'Título'.ljust(max_talk_title_length) + ' ' +
            'Tipo'.ljust(max_talk_type_length) + ' ' +
            'Ponente'.ljust(max_talk_speaker_length) + '\n'
        )
        indexfile.write(separator)

        hyperlinks = []
        for index, talk in enumerate(talks):
            date, title, talk_type, speaker = talk

            # Add hyperlink to title
            title_with_link = "`" + title + "`_"
            indexfile.write(
                date.ljust(max_talk_date_length) + ' ' +
                title_with_link.ljust(max_talk_title_length) + ' ' +
                talk_type.ljust(max_talk_type_length) + ' ' +
                speaker.ljust(max_talk_speaker_length) + '\n'
            )
            hyperlinks.append(".. _`" + title + "`: " + quote(folder_names[index]))

        indexfile.write(separator)
        indexfile.write("\n")

        for hyperlink in hyperlinks:
            indexfile.write(hyperlink + "\n")


def get_talks_metadata():
    talks = []
    talk_date_length = []
    talk_title_length = []
    talk_type_length = []
    talk_speaker_length = []

    folder_names = get_talk_folder_names()

    for folder_name in folder_names:
        name_items = folder_name.split(' - ')
        talk_date = name_items[0]
        talk_title = name_items[1][0:name_items[1].rfind('[')].strip()
        talk_type = name_items[1][name_items[1].rfind('[')+1:-1]
        talk_speaker = name_items[2]
        talks.append([talk_date, talk_title, talk_type, talk_speaker])
        # Keep length of each field (to later get the max)
        talk_date_length.append(len(talk_date))
        talk_title_length.append(len(talk_title))
        talk_type_length.append(len(talk_type))
        talk_speaker_length.append(len(talk_speaker))

    talk_fields_length = [
        talk_date_length,
        talk_title_length,
        talk_type_length,
        talk_speaker_length
    ]
    max_field_lengths = max_talk_metadata_field_length(talk_fields_length)
    return talks, max_field_lengths, folder_names


def get_talk_folder_names():
    folder_names = [str(x) for x in sorted(Path('.').iterdir(), reverse=True)
                    if x.is_dir() and not str(x).startswith(('.', '_', 'docs'))]
    return folder_names


def max_talk_metadata_field_length(talk_field_lengths):
    max_talk_date_length = max(talk_field_lengths[0])
    max_talk_title_length = max(talk_field_lengths[1])
    max_talk_type_length = max(talk_field_lengths[2])
    max_talk_speaker_length = max(talk_field_lengths[3])
    max_lengths = [
        max_talk_date_length,
        max_talk_title_length,
        max_talk_type_length,
        max_talk_speaker_length
    ]
    return max_lengths


def build_readme():
    build_index()
    with open('README.rst', 'wb') as readme:
        # Write header
        readme.write(get_readme_header())
        # Concatenate index and description
        for file in ['description.rst', 'index.rst']:
            with open('docs/'+file, 'rb') as fd:
                shutil.copyfileobj(fd, readme)


def get_readme_header():
    header = b""".. |travis_badge| image:: https://travis-ci.com/python-vigo/charlas.svg?branch=master
    :target: https://travis-ci.com/python-vigo/charlas

.. |repo_size_badge| image:: https://img.shields.io/github/repo-size/python-vigo/charlas.svg

|travis_badge| |repo_size_badge|


"""
    return header


build_readme()
