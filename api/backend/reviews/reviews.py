########################################################
# Sample customers blueprint of endpoints
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
reviews = Blueprint('reviews', __name__)


#------------------------------------------------------------
# Get all reviews from the system
@reviews.route('/reviews', methods=['GET'])
def get_reviews():

    cursor = db.get_db().cursor()
    the_query = '''
    SELECT review_id FROM Review
    '''
    cursor.execute(the_query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# Get reviews from a specified resteraunt
@reviews.route("</reviews/{resteraunt_id}>", methods=["GET"])
def get_resteraunt_reviews(resteraunt_id):
    current_app.logger.info(
        "GET /reviews/{resteraunt_id} reviews route"
    )

    query = """ SELECT content
    FROM Review
    WHERE resteraunt_id = {0}
    """.format(
        resteraunt_id
    )

    cursor = db.get_db().cursor()
    cursor.execute(query)

    theData = cursor.fetchall()

    response = make_response(theData)
    response.status_code = 200
    return response