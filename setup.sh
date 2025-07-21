#!/bin/bash

echo "➡️  Création d'un projet Node + PNPM..."

# Nettoyage
rm -rf cv-creator-ai
mkdir cv-creator-ai
cd cv-creator-ai

# Créer un package.json minimal
cat <<EOF > package.json
{
  "name": "cv-creator-ai",
  "version": "1.0.0",
  "description": "Générateur IA de CV professionnel",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js"
  },
  "author": "ALPHABOK",
  "license": "MIT",
  "dependencies": {
    "express": "^4.18.2",
    "openai": "^4.0.0",
    "cors": "^2.8.5",
    "body-parser": "^1.20.2"
  },
  "devDependencies": {
    "nodemon": "^3.0.2"
  }
}
EOF

# Installer les dépendances
pnpm install

# Créer un fichier index.js de base
cat <<EOF > index.js
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.get("/", (req, res) => {
  res.send("CV Creator AI est prêt !");
});

app.listen(3000, () => {
  console.log("Serveur en écoute sur http://localhost:3000");
});
EOF

echo "✅ Installation terminée. Lance le serveur avec : pnpm dev"
