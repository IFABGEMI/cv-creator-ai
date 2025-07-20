from flask import Flask, request, jsonify, render_template
from prompt_loader import load_prompt
from generator import generate_text
from utils import clean_input, validate_variables

app = Flask(__name__)

@app.route("/", methods=["GET"])
def index():
    return render_template("index.html")

@app.route("/generate", methods=["POST"])
def generate():
    data = request.get_json()
    prompt_type = data.get("type")
    variables = data.get("variables", {})

    try:
        for k in variables:
            variables[k] = clean_input(variables[k])
        prompt_data = load_prompt(prompt_type, variables)
        validate_variables(variables, list(variables.keys()))
        result = generate_text(prompt_data)
        return jsonify({"result": result})
    except Exception as e:
        return jsonify({"error": str(e)}), 400

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
