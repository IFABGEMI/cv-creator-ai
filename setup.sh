#!/bin/bash

# ────────────── 🔧 PARAMÈTRES INITIAUX
set -e  # Stop on error
echo "🚀 Initialisation de l'infrastructure IA..."

# ────────────── 🧱 MISE À JOUR DU SYSTÈME
sudo apt update && sudo apt upgrade -y

# ────────────── 📦 INSTALLATION DES OUTILS DE BASE
sudo apt install -y git curl wget unzip zip build-essential ufw htop

# ────────────── 🐍 INSTALLATION DE PYTHON + VIRTUALENV
sudo apt install -y python3 python3-pip python3-venv
pip3 install virtualenv

# ────────────── 🟦 INSTALLATION DE NODEJS + NPM
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
npm install -g pnpm

# ────────────── 🐳 INSTALLATION DE DOCKER + DOCKER COMPOSE
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER

# ────────────── 🧠 INSTALLATION DE GPT-ENGINEER
cd ~
git clone https://github.com/AntonOsika/gpt-engineer.git
cd gpt-engineer
pip3 install -e .

# ────────────── 🧠 INSTALLATION DE OLLAMA
curl -fsSL https://ollama.com/install.sh | sh
# Préchargement d’un modèle compatible CPU
ollama pull codellama:7b

# ────────────── ⚙️ INSTALLATION DU PROMPT ENGINE (exemple Flask)
cd ~
mkdir prompt-engine && cd prompt-engine
python3 -m venv venv
source venv/bin/activate
pip install flask openai

cat <<EOF > app.py
from flask import Flask, request, jsonify
app = Flask(__name__)

@app.route("/optimize", methods=["POST"])
def optimize():
    data = request.json
    prompt = data.get("prompt", "")
    # Simule une optimisation simple
    return jsonify({"optimized_prompt": f"### OPTIMIZED PROMPT:\\n{prompt}"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
EOF

# Lance le prompt engine en arrière-plan (à adapter avec supervisord ou pm2 plus tard)
nohup venv/bin/python3 app.py &

# ────────────── 🔐 UFW : PARE-FEU BASIQUE
sudo ufw allow OpenSSH
sudo ufw allow 5001    # Prompt Engine
sudo ufw allow 11434   # Ollama
sudo ufw enable

# ────────────── ✅ RÉCAP
echo ""
echo "✅ SETUP TERMINÉ ! Tu peux maintenant :"
echo "1. Tester Prompt Engine : curl -X POST http://localhost:5001/optimize -d '{\"prompt\":\"exemple\"}' -H 'Content-Type: application/json'"
echo "2. Utiliser GPT-Engineer depuis ~/gpt-engineer"
echo "3. Modifier ton Prompt Engine dans ~/prompt-engine/app.py"
echo "4. Lancer Ollama avec : ollama run codellama:7b"
echo "5. Redémarrer ton terminal pour appliquer Docker (si nécessaire)"

