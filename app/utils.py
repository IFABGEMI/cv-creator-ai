import re

def clean_input(text):
    if not isinstance(text, str):
        return ""
    text = text.strip()
    text = re.sub(r"[<>]", "", text)
    return text

def validate_variables(variables: dict, required_keys: list):
    missing = [key for key in required_keys if key not in variables or not variables[key]]
    if missing:
        raise ValueError(f"Champs manquants : {', '.join(missing)}")
    return True
