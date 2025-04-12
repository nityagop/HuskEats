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
admins = Blueprint('admins', __name__)


#------------------------------------------------------------
# Get all admins from the system
@admins.route('/admins', methods=['GET'])
def get_admins():

    cursor = db.get_db().cursor()
    the_query = '''
    SELECT admin_id FROM Admin
    '''
    cursor.execute(the_query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# Get number of users from the system
@admins.route('/users', methods=['GET'])
def get_users():

    cursor = db.get_db().cursor()
    the_query = '''
    SELECT COUNT(*) AS 'Total Number of Users'
    FROM User
    '''
    cursor.execute(the_query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# Get number of active users from the system
@admins.route('/activeUsers', methods=['GET'])
def get_activeUsers():

    cursor = db.get_db().cursor()
    the_query = '''
    SELECT COUNT(*) AS 'Number of Active Users'
    FROM User u
    WHERE u.active_status = 1
    '''
    cursor.execute(the_query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# Update a restaurant's approval status
@admins.route('/restaurant/<restaurant_id>', methods=['PUT'])
def update_restaurantApproval():
    current_app.logger.info('PUT /admins route')
    restaurant_info = request.json
    restaurant_id = restaurant_info['restaurant_id']
    name = restaurant_info['name']
    address = restaurant_info['address']
    image = restaurant_info['image']
    description = restaurant_info['description']
    promotional_image = restaurant_info['promotional_image']
    menu_image = restaurant_info['menu_image']
    hours = restaurant_info['hours']
    approval_status = restaurant_info['approval_status']

    query = '''
    UPDATE Restaurant_Profile
    SET approval_status = %s
    WHERE restaurant_id = %s
    '''
    data = (approval_status, restaurant_id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'restaurant updated!'
#------------------------------------------------------------
# Get total ad revenue from the system
@admins.route('/adRevenue', methods=['GET'])
def get_adRevenue():

    cursor = db.get_db().cursor()
    the_query = '''
    SELECT COUNT(*) AS 'Number of Advertisements', SUM(a.total_cost) 'Total Ad Revenue', SUM(a.total_cost)/COUNT(*) 'Average Revenue of Ad'
    FROM Advertisement a
    '''
    cursor.execute(the_query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# Get ad revenue of an advertisement from the system
@admins.route('/advertisementsByAdvertiser', methods=['GET'])
def get_adsByAdvertisers():
    cursor = db.get_db().cursor()
    the_query = '''
    SELECT SUM(total_cost) AS 'Ad Revenue by Advertiser', advertiser_id AS 'Advertiser ID'
    FROM Advertisement
    GROUP BY advertiser_id
    '''
    cursor.execute(the_query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# Get ad revenue of an advertisement from the system
@admins.route('/advertisements', methods=['GET'])
def get_ads():
    cursor = db.get_db().cursor()
    the_query = '''
    SELECT advertisement_id AS 'Ad ID', advertiser_id AS 'Advertiser ID', total_cost AS 'Ad Cost'
    FROM Advertisement
    '''
    cursor.execute(the_query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response
    
#------------------------------------------------------------
# Get list of unapproved restaurants from the system
@admins.route('/restaurants', methods=['GET'])
def get_restaurants():

    cursor = db.get_db().cursor()
    the_query = '''
    SELECT *
    FROM Restaurant_Profile
    WHERE approval_status = 0
    '''
    cursor.execute(the_query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response






#------------------------------------------------------------
# Get customer detail for customer with particular userID
#   Notice the manner of constructing the query. 
@admins.route('/admins/<userID>', methods=['GET'])
def get_customer(userID):
    current_app.logger.info('GET /customers/<userID> route')
    cursor = db.get_db().cursor()
    cursor.execute('SELECT id, first_name, last_name FROM customers WHERE id = {0}'.format(userID))
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# Makes use of the very simple ML model in to predict a value
# and returns it to the user
@admins.route('/prediction/<var01>/<var02>', methods=['GET'])
def predict_value(var01, var02):
    current_app.logger.info(f'var01 = {var01}')
    current_app.logger.info(f'var02 = {var02}')

    returnVal = predict(var01, var02)
    return_dict = {'result': returnVal}

    the_response = make_response(jsonify(return_dict))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response