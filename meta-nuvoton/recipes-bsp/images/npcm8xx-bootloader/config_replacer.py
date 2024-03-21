from itertools import chain

import configparser
import io
import json
import os
import sys
import xml.etree.ElementTree as ET

XML_PATH = os.path.join("py_scripts", "ImageGeneration", "inputs")
KEY_SETTINGS_PATH = os.path.join("py_scripts", "ImageGeneration")
SETTING_FILE = os.path.join(XML_PATH, "settings.json")


"""
This function loads the settings file and checks if the file exists and is not empty
@param file: the settings file to load
@throws ValueError: if the file doesn't exist or is empty

@return: the settings dictionary
example of the settings file:
{
    "BootBlockAndHeader.xml":
    {
        "MC_CONFIG": "0x05"
    }
}
"""


def load_settings(file: str = SETTING_FILE) -> dict[str, dict[str, str]]:
    if os.path.isfile(file) == False:
        raise FileNotFoundError(f"Error: {file} doesn't exist")
    with open(file) as f:
        settings = json.load(f)
    if settings is None:
        raise ValueError("Error: settings file is empty")
    return settings


def replace_value_in_xml(xml_file: str, dict: dict[str, str], target_xml: str = None):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    # we only interested in the BinField elements
    elements = root.findall("BinField")
    # replace all the value pairs we defined
    for tag, value in dict.items():
        # search all the elements
        search_count = 0
        for element in elements:
            e = element.find("name")
            if e is not None and e.text is not None and e.text == tag:
                c = element.find("content")
                if c is None:
                    raise ValueError(f"Error: {tag} has no content")
                print(f"replacing {tag} value {c.text} to {value}")
                c.text = value
                break
            else:
                search_count += 1
        if search_count == len(elements):
            raise ValueError(f"Error: {tag} not found in the xml file")
    # write the xml file
    if target_xml is not None:
        tree.write(target_xml)
    else:
        tree.write(xml_file)
        pass


"""
Hacks class for ConfigParser to avoid read/write section in the configuration file
"""


class NoSectionConfigParser:
    def __init__(self):
        self._cp = configparser.RawConfigParser()
        self._cp.optionxform = lambda option: option

    def read(self, file: str):
        with open(file) as lines:
            lines = chain(("[DEFAULT]",), lines)
            self._cp.read_file(lines)
            return self._cp.defaults()

    def write(self, file: str):
        data = io.StringIO()
        self._cp.write(data)
        data.seek(0)
        with open(file, "w") as f:
            f.write(data.getvalue().removeprefix("[DEFAULT]\n"))

    def set(self, key: str, value: str):
        dict = self._cp["DEFAULT"]
        if key not in dict:
            raise ValueError(f"Error: {key} not found in the configuration file")
        print(f"replacing {key} value {dict[key]} to {value}")
        dict[key] = value


def replace_value_in_py(py_file: str, dict: dict[str, str], target_py: str = None):
    cp = NoSectionConfigParser()
    cp.read(py_file)
    for key, value in dict.items():
        cp.set(key, value)
    if target_py is not None:
        cp.write(target_py)
    else:
        cp.write(py_file)

def replace_settings_test(file: str):
    settings = load_settings(file=file)        
    # test the function, save results to the test folder
    for config in settings.keys():
        if config.endswith(".xml"):
            replace_value_in_xml(
                os.path.join(XML_PATH, config),
                settings[config],
                os.path.join("test", config),
            )
        elif config.endswith(".py"):
            replace_value_in_py(
                os.path.join(KEY_SETTINGS_PATH, config),
                settings[config],
                os.path.join("test", config),
            )
        else:
            raise ValueError(f"Error: {config} is not supported configuration")

if __name__ == "__main__":
    setting_file = SETTING_FILE
    if len(sys.argv) > 1:
        setting_file = sys.argv[1]

    # load the settings file
    settings = load_settings(setting_file)
    # replace settings in place
    for config in settings.keys():
        if config.endswith(".xml"):
            replace_value_in_xml(os.path.join(XML_PATH, config), settings[config])
        elif config.endswith(".py"):
            replace_value_in_py(os.path.join(KEY_SETTINGS_PATH, config), settings[config])
        else:
            raise ValueError(f"Error: {config} is not supported configuration")
    print("Done")