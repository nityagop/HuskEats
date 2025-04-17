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
from flask import Response

#------------------------------------------------------------
# Create a new Blueprint object, which is a collection of 
# routes.
restaurant_owners = Blueprint('restaurant_owners', __name__, url_prefix="/r")

#------------------------------------------------------------

# get the overall/avg ratings of the restaurant  
@restaurant_owners.route('/restaurant_owners/<restaurant_id>', methods=['GET'])
def get_avg_reviews(restaurant_id):
    cursor = db.get_db().cursor()
    cursor.execute('''
    SELECT r.restaurant_id, rp.name AS restaurant_name, AVG(r.rating) AS average
    FROM Review r
    JOIN Restaurant_Profile rp ON r.restaurant_id = rp.restaurant_id
    WHERE rp.restaurant_id = %s
    GROUP BY r.restaurant_id, rp.name
    ''', (restaurant_id,))  
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# get all individual ratings of the restaurant
@restaurant_owners.route('/restaurant_owners/all_ratings/<restaurant_id>', methods=['GET'])
def get_all_ratings(restaurant_id):
    cursor = db.get_db().cursor()

    cursor.execute('''
        SELECT r.restaurant_id, rp.name AS restaurant_name, r.rating, r.review_id, r.content
        FROM Review r
        JOIN Restaurant_Profile rp ON r.restaurant_id = rp.restaurant_id
        WHERE rp.restaurant_id = %s
    ''', (restaurant_id,))

    ratings_data = cursor.fetchall()
    return make_response(jsonify(ratings_data), 200)


# generate a reply to a review 
@restaurant_owners.route('/restaurant_owners/reply', methods=['POST'])
def add_reply():
    cursor = db.get_db().cursor()
    review_info = request.json
    review_id = review_info.get('review_ids') 
    owner_reply = review_info.get('owner_reply', '')

    cursor.execute(
        'UPDATE Review SET owner_reply = %s WHERE review_id = %s',
        (owner_reply, review_id)
    )

    db.get_db().commit()

    the_response = make_response(jsonify({"message": "Reply added"}))
    the_response.status_code = 200
    return the_response


# access the restaurant profile 
@restaurant_owners.route('/restaurant_owners/profile/<restaurant_id>', methods=['GET'])
def get_profile(restaurant_id):
    cursor = db.get_db().cursor()
    cursor.execute(
        '''SELECT * FROM Restaurant_Profile WHERE restaurant_id = %s''',
        (restaurant_id,)
    )
    data = cursor.fetchall()
    return jsonify(data)

# update profile
@restaurant_owners.route('/restaurant_owners/profile/update', methods=['PUT'])
def update_profile():
    profile_info = request.get_json()

    print("Received profile info:", profile_info)

    try:
        restaurant_id = profile_info['restaurant_id']
        name = profile_info['name']
        address = profile_info['address']
        image = profile_info['image']
        description = profile_info['description']
        promotional_image = profile_info['promotional_image']
        menu_image = profile_info['menu_image']
        hours = profile_info['hours']
        approval_status = profile_info['approval_status']
    except KeyError as e:
        return make_response(jsonify({'error': f'Missing field: {e}'}), 400)

    query = '''
        UPDATE Restaurant_Profile
        SET name = %s, address = %s, image = %s, description = %s,
            promotional_image = %s, menu_image = %s, hours = %s, approval_status = %s
        WHERE restaurant_id = %s
    '''
    data = (name, address, image, description, promotional_image, menu_image, hours, approval_status, restaurant_id)

    cursor = db.get_db().cursor()
    rows_affected = cursor.execute(query, data)
    db.get_db().commit()

    if rows_affected == 0:
        return make_response(jsonify({'message': 'No profile found to update'}), 404)

    return make_response(jsonify({'message': 'Profile updated successfully'}), 200)


