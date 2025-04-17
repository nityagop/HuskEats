########################################################
# blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################

import datetime
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

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
            select rp.restaurant_id AS 'Restaurant ID',
            rp.name as 'Restaurant Name', 
            rp.address as 'Address',
            avg(r.rating) as 'Rating',
            rp.description as 'Restaurant Description'
        FROM Restaurant_Profile rp
        JOIN Review r ON rp.restaurant_id = r.restaurant_id
        WHERE rp.approval_status = 1
        GROUP BY rp.restaurant_id, rp.name, rp.address, rp.description
        order by Rating desc;
    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------

# get all reviews for a certain resutrant
@students.route('/reviews/<restaurant_id>', methods=['GET'])
def get_restReviews(restaurant_id):

    cursor = db.get_db().cursor()
    query = '''
    select r.title, r.rating, r.content, r.image, u.first_name
    from Restaurant_Profile rp join Review r on rp.restaurant_id = r.restaurant_id
    join User u on r.user_id = u.user_id
    where rp.restaurant_id = %s
    GROUP BY rp.restaurant_id, rp.name, rp.address
    ORDER BY Rating DESC;
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
    select rp.restaurant_id, rp.name as 'Restaurant Name', 
    rp.address as 'Address',
    AVG(r.rating) AS 'Rating',
    rp.description as 'Restaurant Description'
    from Restaurant_Profile rp join User_Favorites uf on rp.restaurant_id = uf.restaurant_id
    join User u on uf.user_id = u.user_id JOIN Review r ON rp.restaurant_id = r.restaurant_id
    where u.user_id = %s
    group by rp.restaurant_id, rp.name, rp.address, rp.description
    order by Rating desc;
    '''

    cursor.execute(query, (user_id, ))
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
@students.route('/reviews/<user_id>/<restaurant_id>', methods=["POST"])
def post_review(user_id, restaurant_id):
    current_app.logger.info("POST /reviews/<user_id>/<restaurant_id> route")
    reviews_info = request.json
    title = reviews_info["title"]
    rating = reviews_info["rating"]
    content = reviews_info["content"]

    query = """INSERT INTO Review (user_id, restaurant_id, title, rating, content)
                   VALUES (%s, %s, %s, %s, %s)
    """
    data = (
        user_id,
        restaurant_id,
        title,
        rating,
        content
    )
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    response = make_response(jsonify("created review at {review_id}"))
    response.status_code = 200
    return response
#------------------------------------------------------------
# Update users last use date
@students.route('/userLastUseDate/<user_id>', methods=['PUT'])
def update_userStatus(user_id):
    current_app.logger.info('PUT /userLastUseDate route')
    query = '''
    UPDATE User
    SET last_use_date = %s
    WHERE user_id = %s
    ''' 
    currentDate = datetime.date.today()
    data = (currentDate, user_id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'user last use date updated!'
#------------------------------------------------------------
# Deletes a users favorite restaurant
@students.route('/favorites/<user_id>/<restaurant_id>', methods=['DELETE'])
def delete_favorite(user_id, restaurant_id):
    cursor = db.get_db().cursor()

    delete_query = '''
    delete from User_Favorites 
    where user_id = %s AND restaurant_id = %s
    '''
    cursor.execute(delete_query, (user_id, restaurant_id))
    db.get_db().commit()

    return make_response(jsonify({"message": "Favorite deleted"}), 200)