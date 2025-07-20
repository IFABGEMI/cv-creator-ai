import requests
import os

LLM_ENDPOINT = os.getenv("LLM_ENDPOINT", "http://localhost:11434/v1/chat/completions")

def generate_text(prompt_data):
    system_prompt = prompt_data.get("role", "Tu es un assistant utile.")
    user_prompt = build_user_prompt(prompt_data)

    payload = {
        "model": "deepseek-coder",
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_prompt}
        ],
        "temperature": 0.7,
        "max_tokens": 1024,
    }

    response = requests.post(LLM_ENDPOINT, json=payload)

    if response.status_code != 200:
        raise Exception(f"Erreur LLM : {response.status_code} - {response.text}")

    result = response.json()
    return result["choices"][0]["message"]["content"]

def build_user_prompt(prompt_data):
    objectif = prompt_data.get("objectif", "")
    instruction = prompt_data.get("instruction", "")
    contenu = prompt_data.get("contenu", {})

    contenu_str = "\n".join([f"{key.replace('_', ' ').capitalize()} : {value}" for key, value in contenu.items()])
    return f"{objectif}\n\n{contenu_str}\n\n{instruction}"
