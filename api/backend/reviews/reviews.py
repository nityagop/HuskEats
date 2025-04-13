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

#------------------------------------------------------------
# Create a new Review
@reviews.route("/reviews/{resteraunt_id}", methods=["POST"])
def post_review():
    current_app.logger.info("POST /review route")
    reviews_info = request.json
    user_id = reviews_info["user_id"]
    resteraunt_id = reviews_info["resteraunt_id"]
    title = reviews_info["title"]
    rating = reviews_info["rating"]
    content = reviews_info["content"]
    image = reviews_info["image"]
    date_reported = reviews_info["date_reported"]
    review_id = reviews_info["review_id"]

    query = """INSERT INTO Review (user_id, resteraunt_id, title, rating, content, image, date_reported,review_id)
                   VALUES (%s, %s, %s, %s, %s, %s, %s,%s)
    """
    data = (
        user_id,
        resteraunt_id,
        title,
        rating,
        content,
        image,
        date_reported,
        review_id
    )
    cursor = db.get_db().cursor()
    cursor.execute(query, data)

    response = make_response(jsonify("created review at {review_id}"))
    response.status_code = 200
    return response
