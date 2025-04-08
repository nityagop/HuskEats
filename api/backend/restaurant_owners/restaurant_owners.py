########################################################
# Sample restaurant owners blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################

from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict

#------------------------------------------------------------
# Create a new Blueprint object, which is a collection of 
# routes.
restaurant_owners = Blueprint('restaurant_owners', __name__)

#------------------------------------------------------------

# get all reviews 
@restaurant_owners.route('/restaurant_owners', methods=['GET'])
def get_customers():
    cursor = db.get_db().cursor()
    cursor.execute('''
    SELECT
    r.restaurant_id,
    rp.name AS restaurant_name,
    AVG(r.rating) AS average
    FROM Review r
    JOIN Restaurant_Profile rp ON r.restaurant_id = rp.restaurant_id
    WHERE rp.restaurant_id = 2345
    GROUP BY r.restaurant_id, rp.name;
    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response