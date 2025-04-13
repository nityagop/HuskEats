########################################################
# blueprint of endpoints
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
students = Blueprint('students', __name__)

#------------------------------------------------------------

# get all restaurants
@students.route('/top-rest', methods=['GET'])
def get_topRestaurants():
    cursor = db.get_db().cursor()
    cursor.execute('''
    select rp.name as 'resturants' 
    from Restaurant_Profile rp join Review r on rp.restaurant_id = r.restaurant_id
    GROUP BY rp.restaurant_id, rp.name
    order by avg(r.rating) desc;
    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------

# get all reviews for a certain resutrant
@students.route('/reviews/<resturaunt_id>', methods=['GET'])
def get_restReviews(resturaunt_id):

    cursor = db.get_db().cursor()
    query = '''
    select r.title, r.rating, r.content, r.image, u.first_name
    from Restaurant_Profile rp join Review r on rp.restaurant_id = r.restaurant_id
    join User u on r.user_id = u.user_id
    where rp.restaurant_id = %s
    '''

    cursor.execute(query, (restaurant_id,))
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------

# get favorites list of a student
@students.route('/favorites/<user_id>', methods=['GET'])
def get_userFavorites(user_id):

    cursor = db.get_db().cursor()
    query = '''
    select rp.name, rp.restaurant_id from Restaurant_Profile rp join User_Favorites uf on rp.restaurant_id = uf.restaurant_id
    join User u on uf.user_id = u.user_id
    where u.user_id = %s
    '''

    cursor.execute(query, (user_id))
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response


#------------------------------------------------------------

# filters restraunt by tags
@students.route('/restaurant/<tag_id>', methods=['GET'])
def get_tagrest(tag_id):

    cursor = db.get_db().cursor()
    query = '''
    select rp.name, rp.restaurant_id from Restaurant_Profile rp join Restaurant_Tags rt on rp.restaurant_id = rt.restaurant_id
    join Tag t on rt.tag_id = t.tag_id
    where t.tag_id = %s;
    '''

    cursor.execute(query, (tag_id))
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# Create a new Review
@students.route('/reviews/<user_id>/<resturaunt_id>', methods=["POST"])
def post_review(user_id, resturaunt_id):
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