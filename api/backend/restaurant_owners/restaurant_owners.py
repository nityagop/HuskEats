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

# get the overall/avg reviews 
@restaurant_owners.route('/restaurant_owners/<restaurant_id>', methods=['GET'])
def get_avg_reviews(restaurant_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT r.restaurant_id, rp.name AS restaurant_name, AVG(r.rating) AS average FROM Review r JOIN Restaurant_Profile rp ON r.restaurant_id = rp.restaurant_id WHERE rp.restaurant_id = {0} GROUP BY r.restaurant_id, rp.name'.format(restaurant_id))
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# see the popularity of the restaurant 
@restaurant_owners.route('/restaurant_owners/<restaurant_id>', methods=['GET'])
def get_review(restaurant_id):
    cursor = db.get_db().cursor()
    
    cursor.execute('SELECT r.restaurant_id, rp.name AS restaurant_name, r.content, COUNT(r.review_id) AS total_reviews FROM Review r JOIN Restaurant_Profile rp ON r.restaurant_id = rp.restaurant_id WHERE rp.restaurant_id = {0} GROUP BY r.restaurant_id, rp.name'.format(restaurant_id))
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# generate a reply to a review 
@restaurant_owners.route('/restaurant_owners', methods=['POST'])
def add_reply():
    cursor = db.get_db().cursor()

    review_info = request.json
    review_id = review_info['review_id']
    user_id = review_info['user_id']
    restaurant_id = review_info['restaurant_id']
    title = review_info['title']
    rating = review_info['rating']
    content = review_info['content']
    image = review_info['image']
   
    cursor.execute(f'''INSERT INTO Review (review_id, user_id, restaurant_id, title, rating, content, image) VALUES('{review_id}', '{user_id}', '{restaurant_id}', '{title}', '{rating}', '{content}', '{image})''')

    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response


# create restaurant profile 
@restaurant_owners.route('/restaurant_owners/profile', methods=['POST'])
def add_profile():
    cursor = db.get_db().cursor()
    profile_info = request.json 
    restaurant_id = profile_info['restaurant_id']
    name = profile_info['name']
    address = profile_info['address']
    image = profile_info['image']
    description = profile_info['description']
    promotional_image = profile_info['promotional_image']
    menu_image = profile_info['menu_image']
    hours = profile_info['hours']
    approval_status = profile_info['approval_status']

    cursor.execute(f'''INSERT INTO Restaurant_Profile(restaurant_id, name, address, image, description, promotional_image, menu_image, hours, approval_status) VALUES('{restaurant_id}', '{name}', '{address}', '{image}', '{description}', '{promotional_image}', '{menu_image}', '{hours}', '{approval_status}')''')
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# update restaurant profile 
@restaurant_owners.route('/restaurant_owners/profile', methods=['PUT'])
def update_profile():
    profile_info = request.json 
    restaurant_id = profile_info['restaurant_id']
    name = profile_info['name']
    address = profile_info['address']
    image = profile_info['image']
    description = profile_info['description']
    promotional_image = profile_info['promotional_image']
    menu_image = profile_info['menu_image']
    hours = profile_info['hours']
    approval_status = profile_info['approval_status']

    query = 'UPDATE Restaurant_Profile SET name = %s, address = %s, image = %s, description = %s, promotional_image = %s, menu_image = %s, hours = %s, approval_status = %s where id = %s'
    data = (restaurant_id, name, address, image, description, promotional_image, menu_image, hours, approval_status)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'profile updated!'

