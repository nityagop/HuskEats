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
advertiser = Blueprint("advertiser", __name__, url_prefix="/ad")


# Create a new advertisement
@advertiser.route("/advertisement", methods=["POST"])
def post_advertisement():
    current_app.logger.info("POST /advertisement route")
    ad_content = request.json
    advertiser_id = int(ad_content["advertiser_id"])
    advertisement_id = int(ad_content["advertisement_id"])
    ad_content = ad_content["content"]

    query = """INSERT INTO Advertisement (advertiser_id, content, advertisement_id)
                   VALUES (%s, %s, %s)
    """
    data = (
        advertiser_id,
        ad_content,
        advertisement_id,
    )

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    response = make_response(jsonify("created ad at {ad_id}"))
    response.status_code = 200
    return response


# Update content of the existing ad
@advertiser.route("/advertisement/<ad_id>/<content>", methods=["PUT"])
def update_advertisement(ad_id, content):
    current_app.logger.info("PUT /advertisement/<ad_id> route")
    query = """ UPDATE Advertisement a
    SET a.content= %s
    WHERE a.advertisement_id = %s
    """

    data = (content, ad_id)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    response = make_response(jsonify("updated ad at {ad_id}"))
    response.status_code = 200
    return response


# Return all ads associated with this advertiser
@advertiser.route("/ad_space/advertisement/<advertiser_id>", methods=["GET"])
def existing_ads(advertiser_id):
    current_app.logger.info(
        "GET /ad_space/advertisement/{advertiser_id} advertisements route"
    )

    query = """ SELECT advertisement_id, content
    FROM Advertisement
    WHERE advertiser_id = %s
    """
    data = advertiser_id

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    theData = cursor.fetchall()

    response = make_response(jsonify(theData))
    response.status_code = 200
    return response


# Upload ad to adspace
@advertiser.route("/ad_space/advertisement/<ad_space_id>/<ad_id>", methods=["PUT"])
def add_to_adspace(ad_id, ad_space_id):
    current_app.logger.info(
        "PUT /ad_space/advertisement/{ad_space_id}/{ad_id} addition route"
    )

    query = """ UPDATE Ad_Space
    SET purchased_status = True, advertisement_id = %s
    WHERE ad_space_id = %s
    """

    data = (ad_id, ad_space_id)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    response = make_response(jsonify("added ad at {ad_id} to ad space {ad_space_id}"))
    response.status_code = 200
    return response


# Remove ad from adspace
@advertiser.route("/ad_space/advertisement/<ad_space_id>", methods=["PUT"])
def remove_from_adspace(ad_space_id):
    current_app.logger.info(
        "PUT /ad_space/advertisement/{ad_space_id}/{ad_id} removal route"
    )

    query = """ UPDATE Ad_Space
    SET purchased_status = False, advertisement_id = NULL
    WHERE ad_space_id = %s
    """

    data = (ad_space_id,)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    response = make_response(jsonify("added ad at {ad_id} to ad space {ad_space_id}"))
    response.status_code = 200
    return response


# Show available ad spaces
@advertiser.route("/ad_spaces", methods=["GET"])
def available_adspace():
    current_app.logger.info("GET /ad_spaces route")

    query = """ SELECT *
    FROM Ad_Space
    """

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    theData = cursor.fetchall()

    response = make_response(jsonify(theData))
    response.status_code = 200
    return response
