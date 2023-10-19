from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/endpoint', methods=['GET'])
def get_data():
    data = {}  # Aquí iría la lógica para leer los datos de la base de datos
    return jsonify(data)