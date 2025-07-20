import json
import os

def load_prompt(prompt_type, variables):
    prompt_path = os.path.join("..", "prompts", f"{prompt_type}_prompt.json")

    if not os.path.exists(prompt_path):
        raise FileNotFoundError(f"Le fichier {prompt_type}_prompt.json est introuvable.")

    with open(prompt_path, "r", encoding="utf-8") as f:
        prompt_template = json.load(f)

    prompt_str = json.dumps(prompt_template)

    for key, value in variables.items():
        prompt_str = prompt_str.replace(f"{{{{{key}}}}}", value)

    final_prompt = json.loads(prompt_str)
    return final_prompt
