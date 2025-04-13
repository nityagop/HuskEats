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

# get all restaurants with reviews over 4 starts
@students.route('/top-rest', methods=['GET'])
def get_topRestaurants():
    cursor = db.get_db().cursor()
    cursor.execute('''
    select rp.name as 'top resturants' 
    from Restaurant_Profile rp join Review r on rp.restaurant_id = r.restaurant_id
    GROUP BY rp.restaurant_id, rp.name
    HAVING avg(r.rating) >= 4
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
# write a review for a resturant
