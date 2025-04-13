########################################################
# Advertiser route blueprint of endpoints
########################################################

from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db


# Create new blueprint (collection of routes)
advertiser = Blueprint("advertiser", __name__)


# Create a new advertisement
@advertiser.route("/advertisement", methods=["POST"])
def post_advertisement():
    current_app.logger.info("POST /advertisement route")
    ad_info = request.json
    advertiser_id = ad_info["advertiser_id"]
    content = ad_info["content"]
    active_start_date = ad_info["active_start_date"]
    active_end_date = ad_info["active_end_date"]
    ad_type = ad_info["type"]
    cost = ad_info["total_cost"]
    ad_id = ad_info["advertisement_id"]

    query = """INSERT INTO Advertisement (advertiser_id, content, active_start_date, active_end_date, type, total_cost, advertisement_id)
                   VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    data = (
        advertiser_id,
        content,
        active_start_date,
        active_end_date,
        ad_type,
        cost,
        ad_id,
    )
    cursor = db.get_db().cursor()
    cursor.execute(query, data)

    response = make_response(jsonify("created ad at {ad_id}"))
    response.status_code = 200
    return response


# Update type & content of the existing ad
@advertiser.route("/advertisement/<int: ad_id>", methods=["PUT"])
def update_advertisement(ad_id):
    current_app.logger.info("PUT /advertisement/<ad_id> route")
    ad_update_info = request.json
    content = ad_update_info["content"]
    ad_type = ad_update_info["type"]
    query = """ UPDATE Advertisement
    SET content={0}, type = {1}
    WHERE advertisement_id = {2}
    """.format(
        content, ad_type, ad_id
    )

    cursor = db.get_db().cursor()
    cursor.execute(query)

    response = make_response(jsonify("updated ad at {ad_id}"))
    response.status_code = 200
    return response


# Return all ads associated with this advertiser
@advertiser.route("</ad_space/advertisement/{advertiser_id}>", methods=["GET"])
def add_to_adspace(advertiser_id):
    current_app.logger.info(
        "GET /ad_space/advertisement/{advertiser_id} advertisements route"
    )

    query = """ SELECT content
    FROM Advertisement
    WHERE advertiser_id = {0}
    """.format(
        advertiser_id
    )

    cursor = db.get_db().cursor()
    cursor.execute(query)

    theData = cursor.fetchall()

    response = make_response(theData)
    response.status_code = 200
    return response


# Upload ad to adspace
@advertiser.route("</ad_space/advertisement/{ad_space_id}/{ad_id}>", methods=["PUT"])
def add_to_adspace(ad_id, ad_space_id):
    current_app.logger.info(
        "PUT /ad_space/advertisement/{ad_space_id}/{ad_id} addition route"
    )

    query = """ UPDATE Ad_Space
    SET purchased = True, advertisement_id = {0}
    WHERE ad_space_id = {1}
    """.format(
        ad_id, ad_space_id
    )

    cursor = db.get_db().cursor()
    cursor.execute(query)

    response = make_response(jsonify("added ad at {ad_id} to ad space {ad_space_id}"))
    response.status_code = 200
    return response


# Remove ad from adspace
@advertiser.route("</ad_space/advertisement/{ad_space_id}/{ad_id}>", methods=["PUT"])
def remove_from_adspace(ad_space_id):
    current_app.logger.info(
        "PUT /ad_space/advertisement/{ad_space_id}/{ad_id} removal route"
    )

    query = """ UPDATE Ad_Space
    SET purchased = False, advertisement_id = Null
    WHERE ad_space_id = {0}
    """.format(
        ad_space_id
    )

    cursor = db.get_db().cursor()
    cursor.execute(query)

    response = make_response(jsonify("added ad at {ad_id} to ad space {ad_space_id}"))
    response.status_code = 200
    return response
