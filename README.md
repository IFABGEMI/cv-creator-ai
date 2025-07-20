# CV Creator AI

Un outil IA open-source clé en main pour générer :
- des CV professionnels,
- des lettres de motivation,
- des résumés LinkedIn,
- multilingues et optimisés pour les recruteurs (ATS-ready).

## 🧰 Stack technique
- 🧠 LLM : DeepSeek (via Ollama)
- 🧩 Orchestration : n8n
- 🌍 Traduction : Argos Translate
- 🖥️ Interface : Flask (ou Streamlit/React)
- 📄 Export PDF : WeasyPrint

## 🚀 Lancement rapide

```bash
git clone https://github.com/<ton-user>/cv-creator-ai.git
cd cv-creator-ai
docker-compose up --build
