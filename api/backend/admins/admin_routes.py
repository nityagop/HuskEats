########################################################
# Sample customers blueprint of endpoints
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
@admins.route('/restaurant/<restaurant_id>/<approval_str>', methods=['PUT'])
def update_restaurantApproval(restaurant_id, approval_str):
    current_app.logger.info('PUT /restaurant/<restaurant_id> route')
    query = '''
    UPDATE Restaurant_Profile
    SET approval_status = %s
    WHERE restaurant_id = %s
    '''
    if approval_str == 'approve':
        approval_status = True
    elif approval_str == 'reject':
        approval_status = False
    else:
        return 'Invalid approval status. Use "approve" or "reject".'
    
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
    SELECT SUM(ad.total_cost) AS 'Ad Revenue by Advertiser', a.advertiser_name AS 'Advertiser Name'
    FROM Advertisement ad JOIN Advertiser a ON a.advertiser_id = ad.advertiser_id
    GROUP BY ad.advertiser_id
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
    SELECT ad.advertisement_id AS 'Ad ID', a.advertiser_name AS 'Advertiser Name', ad.total_cost AS 'Ad Cost'
    FROM Advertisement ad JOIN Advertiser a ON a.advertiser_id = ad.advertiser_id
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
    SELECT restaurant_id AS 'Restaurant ID', name AS 'Restaurant Name', address AS 'Address', description AS 'Restaurant Description', hours AS 'Hours of Operation', approval_status
    FROM Restaurant_Profile
    WHERE approval_status = 0
    '''
    cursor.execute(the_query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# Update users active status
@admins.route('/userStatus', methods=['PUT'])
def update_userStatus():
    current_app.logger.info('PUT /userStatus route')
    query = '''
    UPDATE User
    SET active_status = last_use_date >= %s
    ''' 
    date90DaysAgo = datetime.datetime.now() - datetime.timedelta(days=90)
    data = (date90DaysAgo.strftime('%Y-%m-%d'))
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'user status updated!'